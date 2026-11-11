#!/usr/bin/env bash
# Runs every Molecule scenario of the given elgeeko1 collections, one molecule test run per
# platform, with at most --jobs runs at a time.
#
# Rootless Podman charges the inotify instances of every container to the user who runs Molecule,
# and systemd exits at boot once fs.inotify.max_user_instances is reached, so --jobs bounds the
# number of systemd containers that run at once. Each run keeps its Molecule state and its output
# in .molecule/<collection>.<instance> of the repository, so runs of one scenario on different
# platforms share no state. An interrupt stops the running molecule processes and leaves their
# containers, which the destroy step of the next run of the same instance removes.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_NAME="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "${SCRIPT_DIR}")"
COLLECTIONS_ROOT="${REPO_ROOT}/ansible_collections/elgeeko1"
RUN_ROOT="${REPO_ROOT}/.molecule"
readonly SCRIPT_NAME SCRIPT_DIR REPO_ROOT COLLECTIONS_ROOT RUN_ROOT

# ANSI SGR escapes; yellow is bold (1;33) because plain 33 renders as dim brown
# on many terminals
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

max_jobs=2
collections=()
# <collection>.<instance> of each running molecule process, keyed by PID; global so that the
# signal trap can reach it
declare -A running=()
failures=()

print_usage() {
  echo -e "Usage: ${SCRIPT_NAME} [options] <collection>..."
  echo -e ""
  echo -e "Run every Molecule scenario of each collection, one platform per run."
  echo -e ""
  echo -e "Options:"
  echo -e "  --jobs <n>                 maximum concurrent runs, 0 for no limit (default: ${max_jobs})"
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
      -h | --help)
        print_usage
        exit 0
        ;;
      --jobs)
        [[ $# -ge 2 ]] || die "--jobs requires a value"
        max_jobs="$2"
        shift
        ;;
      --jobs=*)
        max_jobs="${1#--jobs=}"
        ;;
      -*)
        die "unknown argument: $1"
        ;;
      *)
        collections+=("$1")
        ;;
    esac
    shift
  done
}

ensure_molecule_available() {
  command -v molecule >/dev/null 2>&1 || die "molecule not found on PATH"
}

ensure_podman_available() {
  command -v podman >/dev/null 2>&1 || die "podman not found on PATH"
}

# prints one "<scenario> <instance>" line per platform of each scenario in the collection
list_instances() {
  local collection="$1"

  (cd "${COLLECTIONS_ROOT}/${collection}" && molecule list --format plain) | awk '{ print $4, $1 }'
}

start_run() {
  local collection="$1"
  local scenario="$2"
  local instance="$3"

  local run_dir="${RUN_ROOT}/${collection}.${instance}"
  mkdir -p "${run_dir}"
  (
    cd "${COLLECTIONS_ROOT}/${collection}"
    export MOLECULE_EPHEMERAL_DIRECTORY="${run_dir}/state"
    exec molecule test --scenario-name "${scenario}" --platform-name "${instance}"
  ) >"${run_dir}/test.log" 2>&1 &
  running[$!]="${collection}.${instance}"
  log_info "Started ${collection}.${instance}"
}

# waits for one running molecule process to exit and records its result
reap_run() {
  local pid
  local status=0
  wait -n -p pid "${!running[@]}" || status=$?

  local label="${running[${pid}]}"
  unset "running[${pid}]"
  if [[ "${status}" -eq 0 ]]; then
    log_success "Passed ${label}"
  else
    failures+=("${label}")
    log_error "molecule test failed: ${label}, log: ${RUN_ROOT}/${label}/test.log"
  fi
}

stop_runs() {
  if [[ ${#running[@]} -gt 0 ]]; then
    log_warn "Stopping ${#running[@]} running molecule processes"
    # a molecule process can exit before the kill reaches it
    kill -TERM "${!running[@]}" 2>/dev/null || true
  fi
  exit 130
}

main() {
  parse_args "$@"

  [[ ${#collections[@]} -gt 0 ]] || die "missing required argument: <collection>"
  [[ "${max_jobs}" =~ ^[0-9]+$ ]] || die "--jobs is not a non-negative integer: ${max_jobs}"
  local collection
  for collection in "${collections[@]}"; do
    [[ -d "${COLLECTIONS_ROOT}/${collection}" ]] || die "collection not found: ${collection}"
  done

  ensure_molecule_available
  ensure_podman_available

  local runs=()
  local instances scenario instance
  for collection in "${collections[@]}"; do
    instances="$(list_instances "${collection}")"
    while read -r scenario instance; do
      [[ -n "${instance}" ]] || continue
      runs+=("${collection} ${scenario} ${instance}")
    done <<<"${instances}"
  done
  log_info "Runs:    ${#runs[@]}"
  log_info "Jobs:    ${max_jobs}"
  log_info "Logs:    ${RUN_ROOT}"

  trap stop_runs INT TERM
  local run
  for run in "${runs[@]}"; do
    if [[ "${max_jobs}" -gt 0 && ${#running[@]} -ge "${max_jobs}" ]]; then
      reap_run
    fi
    read -r collection scenario instance <<<"${run}"
    start_run "${collection}" "${scenario}" "${instance}"
  done
  while [[ ${#running[@]} -gt 0 ]]; do
    reap_run
  done

  [[ ${#failures[@]} -eq 0 ]] || die "failed runs: ${failures[*]}"
  log_success "Passed all ${#runs[@]} runs"
}

main "$@"
