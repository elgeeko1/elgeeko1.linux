# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `desktop` shows an editable path in the Files toolbar, adds a `desktop` alias, and masks
  `systemd-networkd-wait-online`.
- `passwordless_sudo` grants a user passwordless sudo.
- `ssh_client` creates `~/.ssh/config.d` and includes its files from `~/.ssh/config`.

### Changed

- **BREAKING:** `vmware_guest` moves to the `elgeeko1.engineering` collection.
- **BREAKING:** `terminal` no longer grants passwordless sudo and drops `terminal_user` and
  `terminal_sudo_nopassword`; `passwordless_sudo` grants it to `passwordless_sudo_user`.
- `git` writes its GPG key export to `~/.cache/elgeeko1.workstation/git`.

### Fixed

- `git` runs when `git_generate_gpg` is false and under `--check`, and reports a change when it
  generates a GPG key.
- `ssh_server` runs when `ssh_server_github_username` is unset, and under `--check`.

## [2.0.0] - 2026-11-03

### Added

- Each role declares its variables in `meta/argument_specs.yml`, which ansible-core validates before
  the role runs and `ansible-doc -t role` displays.
- Roles support Ubuntu 26.04 and Debian 13.

### Changed

- **BREAKING:** The collection requires ansible-core 2.22 or later and community.general 14 or
  later, which `meta/runtime.yml` and `galaxy.yml` declare.
- **BREAKING:** `vmware_host` is renamed `vmware_guest`, and its `vmware_host_desktop_enabled` input
  is renamed `vmware_guest_desktop_enabled`.
- `git` fails when `git_github_username` or `git_github_email` is unset.
- `terminal` grants passwordless sudo only when `terminal_sudo_nopassword` is true; it defaults to
  false.

### Deprecated

- Ubuntu 22.04 support is deprecated.

### Removed

- Debian 11 support is removed.
- `terminal` drops the `title` shell function, which `elgeeko1.apps.alacritty` provides.
- `vmware_guest` drops Ubuntu 22.04.

### Fixed

- Roles read host facts from `ansible_facts`, so they run with `INJECT_FACTS_AS_VARS` disabled.
- The collection metadata declares only the MIT license, which covers every file.
- `vmware_guest` installs `open-vm-tools-desktop` with privilege escalation when
  `vmware_guest_desktop_enabled` is true.
- `git` runs on a host that `elgeeko1.linux.core` has not configured.
- `terminal` reports no change on a repeat run.

[2.0.0]: https://github.com/elgeeko1/elgeeko1.linux/releases/tag/v2.0.0
[unreleased]: https://github.com/elgeeko1/elgeeko1.linux/compare/v2.0.0...HEAD
