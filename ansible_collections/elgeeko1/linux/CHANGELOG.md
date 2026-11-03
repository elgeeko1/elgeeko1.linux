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
- `core` does not install `software-properties-common`, which Debian 13 does not ship.
- `core` installs and runs `ntpsec`, which replaces the `ntp` daemon on Ubuntu 22.04 and Debian.

### Deprecated

- Ubuntu 22.04 support is deprecated.

### Removed

- Debian 11 support is removed.

### Fixed

- Roles read host facts from `ansible_facts`, so they run with `INJECT_FACTS_AS_VARS` disabled.
- `core` runs with `core_timezone` unset.
- `core` writes the APT snapshot setting when `core_apt_snapshot` is set.
- `core` updates, upgrades, and installs its APT and Python APT packages on Debian.
- `ubuntu_desktop_ux` schedules a reboot after disabling GNOME technical problem reports instead of
  failing on an undefined handler.
- `ubuntu_desktop_ux` removes existing crash reports from `/var/crash`.

[2.0.0]: https://github.com/elgeeko1/elgeeko1.linux/releases/tag/v2.0.0
