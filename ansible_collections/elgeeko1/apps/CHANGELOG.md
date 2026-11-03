# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-11-03

### Added

- Each role declares its variables in `meta/argument_specs.yml`, which ansible-core validates before
  the role runs and `ansible-doc -t role` displays.
- Roles support Ubuntu 26.04.
- Roles support Debian 13, except `chromium`, `firefox`, `kicad`, and `spotify`.
- `alacritty` adds the `title` shell function to `~/.bash_aliases`.

### Changed

- **BREAKING:** The collection requires ansible-core 2.22 or later and community.general 14 or
  later, which `meta/runtime.yml` and `galaxy.yml` declare.
- **BREAKING:** `docker` configures its APT source as `docker.sources` with its signing key in
  `/etc/apt/keyrings`, which conflicts with the one-line source and `trusted.gpg.d` key on hosts
  that the role configured before.
- `docker`, `tailscale`, and `vscode` download their APT signing key every run, so a key rotation
  reaches the host.
- `vscode` keeps its signing key in `/etc/apt/keyrings`.
- `remmina` installs the FreeRDP 3 clients, except on releases that ship only FreeRDP 2.
- `tailscale` fails with a stated cause when the node is not running and no auth key is available.
- `alacritty` installs the `alacritty` snap instead of the APT package.

### Deprecated

- Ubuntu 22.04 support is deprecated.

### Removed

- Debian 11 support is removed.
- `chromium`, `firefox`, and `kicad` drop Debian, since their Ubuntu PPAs publish no Debian suites.
- `spotify` drops Ubuntu 22.04 and Debian, since its packages do not install there.

### Fixed

- Roles read host facts from `ansible_facts`, so they run with `INJECT_FACTS_AS_VARS` disabled.
- `1password`, `chrome`, `chromium`, `firefox`, `kicad`, and `vscode` install `gpg`, which their APT
  signing-key setup requires.
- `tailscale` installs on Debian.
- `1password`, `chrome`, `spotify`, and `vscode` create their APT source once, at the path and in
  the format that the vendor package maintains, so package upgrades no longer leave a duplicate
  source.
- `spotify` configures its APT source on a fresh host and trusts the current Spotify signing key.
- `vscode` adds the Microsoft APT repository, so `code` installs on a host without one.
- `chromium` installs the xtradeb build for the release of the host.
- `chromium`, `firefox`, `kicad`, `tailscale`, and `zoom` run on a host that `elgeeko1.linux.core`
  has not configured.
- `chromium`, `firefox`, `kicad`, and `zoom` report no change on a repeat run.
- `alacritty` deploys the template named by `alacritty_tmux_config_template`.

[2.0.0]: https://github.com/elgeeko1/elgeeko1.linux/releases/tag/v2.0.0
