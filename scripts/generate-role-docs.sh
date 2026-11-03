#!/usr/bin/env bash
# Renders the variables table in every role README.md from its meta/argument_specs.yml with aar-doc.
# Each README.md must hold the BEGIN_ANSIBLE_DOCS and END_ANSIBLE_DOCS markers that .aar_doc.yml names.
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "${SCRIPT_DIR}")"

for role in "${REPO_ROOT}"/ansible_collections/elgeeko1/*/roles/*/; do
  aar-doc --config-file "${REPO_ROOT}/.aar_doc.yml" "${role}" markdown
done
