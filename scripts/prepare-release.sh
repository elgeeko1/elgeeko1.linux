#!/usr/bin/env bash
# Prepares release X.Y.Z of every elgeeko1 collection in the working tree.
#
# Sets version in each galaxy.yml and turns the Unreleased section of each CHANGELOG.md into
# "## [X.Y.Z] - <UTC date>", with a compare link against the newest v* tag, or a release link when
# no tag exists. A changelog without an Unreleased section gets an empty release section. The
# script does not commit, tag, or push.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_NAME="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "${SCRIPT_DIR}")"
REPO_URL="https://github.com/elgeeko1/elgeeko1.linux"
COLLECTIONS=(linux apps engineering workstation)
readonly SCRIPT_NAME SCRIPT_DIR REPO_ROOT REPO_URL COLLECTIONS

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

dry_run=false
version=""

print_usage() {
  echo -e "Usage: ${SCRIPT_NAME} --version <X.Y.Z> [options]"
  echo -e ""
  echo -e "Set the version of every collection and cut its changelog section."
  echo -e ""
  echo -e "Required:"
  echo -e "  --version <X.Y.Z>          release version"
  echo -e ""
  echo -e "Options:"
  echo -e "  -n, --dry-run              resolve inputs without editing files"
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
      -n | --dry-run)
        dry_run=true
        ;;
      --version)
        [[ $# -ge 2 ]] || die "--version requires a value"
        version="$2"
        shift
        ;;
      --version=*)
        version="${1#--version=}"
        ;;
      *)
        die "unknown argument: $1"
        ;;
    esac
    shift
  done
}

ensure_git_available() {
  command -v git >/dev/null 2>&1 || die "git not found on PATH"
}

resolve_previous_tag() {
  local tags
  mapfile -t tags < <(git -C "${REPO_ROOT}" tag --list 'v*' --sort=-v:refname)
  printf '%s' "${tags[0]:-}"
}

resolve_version_link() {
  local previous_tag="$1"

  if [[ -n "${previous_tag}" ]]; then
    printf '%s' "${REPO_URL}/compare/${previous_tag}...v${version}"
  else
    printf '%s' "${REPO_URL}/releases/tag/v${version}"
  fi
}

verify_version_order() {
  local previous_tag="$1"

  [[ -n "${previous_tag}" ]] || return 0
  local newest
  newest="$(printf '%s\n%s\n' "${previous_tag}" "v${version}" | sort -V | tail -n 1)"
  [[ "${newest}" == "v${version}" && "${previous_tag}" != "v${version}" ]] ||
    die "version is not newer than ${previous_tag}: ${version}"
}

cut_changelog() {
  local changelog="$1"
  local release_date="$2"
  local version_link="$3"

  local updated
  updated="$(awk -v header="## [${version}] - ${release_date}" -v link="[${version}]: ${version_link}" '
    BEGIN { header_done = 0; link_done = 0 }
    /^## \[Unreleased\]$/ && !header_done { print header; header_done = 1; next }
    /^## \[/ && !header_done { print header; print ""; header_done = 1 }
    tolower($0) ~ /^\[unreleased\]: / { next }
    /^\[[0-9]+\.[0-9]+\.[0-9]+\]: / && !link_done { print link; link_done = 1 }
    { print }
    END {
      if (!header_done) { print ""; print header }
      if (!link_done) { print ""; print link }
    }
  ' "${changelog}")"
  # dropping the Unreleased link reference can leave consecutive blank lines
  printf '%s\n' "${updated}" | cat -s >"${changelog}"
}

set_galaxy_version() {
  local galaxy="$1"

  sed -i "s/^version: .*/version: ${version}/" "${galaxy}"
}

main() {
  parse_args "$@"

  [[ -n "${version}" ]] || die "missing required argument: --version"
  [[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "version is not X.Y.Z: ${version}"

  ensure_git_available

  local previous_tag
  previous_tag="$(resolve_previous_tag)"
  verify_version_order "${previous_tag}"
  git -C "${REPO_ROOT}" rev-parse --quiet --verify "refs/tags/v${version}" >/dev/null &&
    die "tag exists: v${version}"

  local collection
  for collection in "${COLLECTIONS[@]}"; do
    local changelog="${REPO_ROOT}/ansible_collections/elgeeko1/${collection}/CHANGELOG.md"
    [[ -f "${changelog}" ]] || die "changelog not found: ${changelog}"
    ! grep -q "^## \[${version}\]" "${changelog}" || die "changelog has a ${version} section: ${changelog}"
    grep -q '^## \[Unreleased\]$' "${changelog}" ||
      log_warn "no Unreleased section, writing an empty ${version} section: ${changelog}"
  done

  local release_date version_link
  release_date="$(date -u +%F)"
  version_link="$(resolve_version_link "${previous_tag}")"
  log_info "Version:       ${version}"
  log_info "Previous tag:  ${previous_tag:-none}"
  log_info "Date:          ${release_date}"
  log_info "Link:          ${version_link}"

  if [[ "${dry_run}" == "true" ]]; then
    log_success "Dry run complete"
    return
  fi

  for collection in "${COLLECTIONS[@]}"; do
    local collection_dir="${REPO_ROOT}/ansible_collections/elgeeko1/${collection}"
    cut_changelog "${collection_dir}/CHANGELOG.md" "${release_date}" "${version_link}"
    set_galaxy_version "${collection_dir}/galaxy.yml"
    log_success "elgeeko1.${collection} set to ${version}"
  done

  log_info "Review the diff and commit it, then tag and push the release commit:"
  log_info "  git tag -a v${version} -m v${version}"
  log_info "  git push origin v${version}"
}

main "$@"
