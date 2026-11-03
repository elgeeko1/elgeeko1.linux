# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
