# SPDX-FileCopyrightText: (c) 2026 Jeff C. Jensen
# SPDX-License-Identifier: MIT

COLLECTIONS := linux apps engineering workstation

.PHONY: help config docs lint test release

help:
	@echo "elgeeko1 collection development tasks."
	@echo ""
	@echo "Usage:"
	@echo "  make config                   # install the dev toolchain, collections, and git hooks"
	@echo "  make docs                     # render the role README variable tables"
	@echo "  make lint                     # run every pre-commit hook on every file"
	@echo "  make test [JOBS=N]            # run every Molecule scenario, N platforms at a time"
	@echo "  make release VERSION=X.Y.Z    # set the collection versions and cut the changelog sections"

.venv:
	$(MAKE) config

## install Python dev deps, the latest matching Ansible collections, and the pre-commit git hooks
config:
	@command -v uv >/dev/null 2>&1 || { echo "Error: 'uv' is not installed or not in PATH."; exit 1; }
	@test -d .venv || uv venv
	@uv pip install -r requirements.txt
	@uv run ansible-galaxy collection install -r collections/requirements.yml -p collections --upgrade
	@uv run pre-commit install --hook-type pre-commit --hook-type pre-push

docs: | .venv
	@uv run scripts/generate-role-docs.sh

lint: | .venv
	@uv run pre-commit run --all-files

test: | .venv
	@uv run scripts/molecule-test.sh $(if $(JOBS),--jobs $(JOBS)) $(COLLECTIONS)

release:
	@scripts/prepare-release.sh --version "$(VERSION)"
