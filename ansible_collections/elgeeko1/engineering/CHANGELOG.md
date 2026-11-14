# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- The collection holds `vscode` and `kicad` from `elgeeko1.apps` and `vmware_guest` from
  `elgeeko1.workstation`.
- `vmware_workstation` installs VMware Workstation Pro from a user-supplied installer, and builds
  and signs its kernel modules for the running kernel and each kernel installed later.

### Fixed

- `vscode` keeps the `code` package from adding its own APT source or key, and removes the
  `vscode.list` source and `/etc/apt/trusted.gpg.d` key of `code` 1.100 and earlier, which made
  `apt update` fail on conflicting `Signed-By` values.

[unreleased]: https://github.com/elgeeko1/elgeeko1.linux/compare/v2.0.0...HEAD
