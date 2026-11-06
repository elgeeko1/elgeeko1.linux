#!/usr/bin/env bash
# Builds the VMware vmmon and vmnet kernel modules for a kernel, signing them under Secure Boot.
#
# Builds for the running kernel unless --kernel names another release. For the running kernel it
# then restarts the vmware service, which loads the modules, unless --no-restart is given, and
# refuses to restart while a virtual machine is running. Under Secure Boot it signs with the MOK in
# /var/lib/vmware-mok, whose certificate must be enrolled before the kernel loads the modules.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_NAME="$(basename "$0")"
RUNNING_RELEASE="$(uname -r)"
MOK_DIR="/var/lib/vmware-mok"
KEY_PATH="${MOK_DIR}/MOK.priv"
CERT_PATH="${MOK_DIR}/MOK.der"
MODULES=(vmmon vmnet)
readonly SCRIPT_NAME RUNNING_RELEASE MOK_DIR KEY_PATH CERT_PATH MODULES

kernel_release="${RUNNING_RELEASE}"
restart="true"

if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  C_RESET='\033[0m'
  C_RED='\033[0;31m'
  C_GREEN='\033[0;32m'
  C_YELLOW='\033[1;33m'
  C_BLUE='\033[0;34m'
else
  C_RESET=''
  C_RED=''
  C_GREEN=''
  C_YELLOW=''
  C_BLUE=''
fi
readonly C_RESET C_RED C_GREEN C_YELLOW C_BLUE

print_usage() {
  echo -e "Usage: ${SCRIPT_NAME} [options]"
  echo -e ""
  echo -e "Build the VMware kernel modules for a kernel, signing them under Secure Boot."
  echo -e ""
  echo -e "Options:"
  echo -e "  --kernel RELEASE           kernel release to build for (default: the running kernel)"
  echo -e "  --no-restart               do not restart the vmware service"
  echo -e "  -h, --help                 show this help and exit"
}

log_info() { printf '%b[INFO]%b %s\n' "${C_BLUE}" "${C_RESET}" "$*"; }
log_warn() { printf '%b[WARN]%b %s\n' "${C_YELLOW}" "${C_RESET}" "$*"; }
log_success() { printf '%b[ OK ]%b %s\n' "${C_GREEN}" "${C_RESET}" "$*"; }
log_error() { printf '%b[ERR ]%b %s\n' "${C_RED}" "${C_RESET}" "$*" >&2; }
die() {
  log_error "$*"
  exit 1
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --kernel)
        [[ $# -ge 2 ]] || die "missing value: --kernel"
        kernel_release="$2"
        shift 2
        ;;
      --kernel=*)
        kernel_release="${1#*=}"
        shift
        ;;
      --no-restart)
        restart="false"
        shift
        ;;
      -h | --help)
        print_usage
        exit 0
        ;;
      *)
        die "unknown argument: $1"
        ;;
    esac
  done
}

ensure_root_user() {
  [[ "${EUID}" -eq 0 ]] || die "not running as root"
}

ensure_vmware_modconfig_available() {
  command -v vmware-modconfig >/dev/null 2>&1 || die "vmware-modconfig not found on PATH"
}

ensure_gcc_available() {
  command -v gcc >/dev/null 2>&1 || die "gcc not found on PATH"
}

ensure_mokutil_available() {
  command -v mokutil >/dev/null 2>&1 || die "mokutil not found on PATH"
}

ensure_kernel_headers_present() {
  [[ -d "/lib/modules/${kernel_release}/build/include" ]] ||
    die "kernel headers not found: /lib/modules/${kernel_release}/build/include"
}

ensure_signing_inputs_present() {
  [[ -f "${KEY_PATH}" ]] || die "signing key not found: ${KEY_PATH}"
  [[ -f "${CERT_PATH}" ]] || die "signing certificate not found: ${CERT_PATH}"
  [[ -x "$(resolve_sign_file)" ]] || die "sign-file not found: $(resolve_sign_file)"
}

ensure_no_running_vms() {
  ! pgrep -x vmware-vmx >/dev/null || die "virtual machines are running"
}

resolve_sign_file() {
  printf '%s' "/lib/modules/${kernel_release}/build/scripts/sign-file"
}

# mokutil fails on a host without EFI variables, which has no Secure Boot
resolve_secure_boot() {
  if mokutil --sb-state 2>/dev/null | grep -q '^SecureBoot enabled'; then
    printf 'true'
  else
    printf 'false'
  fi
}

build_module() {
  local module="$1"
  local gcc_path="$2"

  # destination directory is relative to /lib/modules/<release>, and .ko is appended to the name
  vmware-modconfig --console --build-mod "${module}" "${gcc_path}" \
    "/lib/modules/${kernel_release}/build/include" misc "${module}"
}

sign_module() {
  local module="$1"

  "$(resolve_sign_file)" sha256 "${KEY_PATH}" "${CERT_PATH}" \
    "/lib/modules/${kernel_release}/misc/${module}.ko"
}

main() {
  parse_args "$@"

  ensure_root_user
  ensure_vmware_modconfig_available
  ensure_gcc_available
  ensure_mokutil_available
  ensure_kernel_headers_present

  local secure_boot
  secure_boot="$(resolve_secure_boot)"
  if [[ "${secure_boot}" == "true" ]]; then
    ensure_signing_inputs_present
  fi

  if [[ "${kernel_release}" != "${RUNNING_RELEASE}" ]]; then
    restart="false"
  fi
  if [[ "${restart}" == "true" ]]; then
    ensure_no_running_vms
  fi

  local gcc_path
  gcc_path="$(command -v gcc)"
  log_info "Kernel:       ${kernel_release}"
  log_info "Secure Boot:  ${secure_boot}"
  log_info "Restart:      ${restart}"
  log_info "GCC:          ${gcc_path}"

  local module
  for module in "${MODULES[@]}"; do
    log_info "Building ${module}"
    build_module "${module}" "${gcc_path}"
    if [[ "${secure_boot}" == "true" ]]; then
      log_info "Signing ${module}"
      sign_module "${module}"
    fi
  done

  depmod "${kernel_release}"
  if [[ "${restart}" == "true" ]]; then
    log_info "Restarting vmware service"
    systemctl restart vmware
  fi
  log_success "Built ${MODULES[*]} for ${kernel_release}"
}

main "$@"
