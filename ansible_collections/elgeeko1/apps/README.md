# elgeeko1.apps

Desktop and developer applications for Debian and Ubuntu hosts.

## Requirements

- ansible-core 2.22 or later.
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, on the managed hosts. Ubuntu 22.04 support is
  deprecated. A role README names any narrower platform support.

## Installation

Install a release by its tag from the
[releases](https://github.com/elgeeko1/elgeeko1.linux/releases), replacing `vX.Y.Z`:

```bash
ansible-galaxy collection install "git+https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/apps,vX.Y.Z"
```

Or list it in a `requirements.yml`:

```yaml
collections:
  - name: https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/apps
    type: git
    version: vX.Y.Z
```

## Roles

- [`elgeeko1.apps.1password`](roles/1password/README.md): Installs 1Password and the 1Password CLI
  from the 1Password APT repository.
- [`elgeeko1.apps.alacritty`](roles/alacritty/README.md): Installs the Alacritty terminal emulator
  with an optional tmux configuration.
- [`elgeeko1.apps.chrome`](roles/chrome/README.md): Installs Google Chrome stable from the Google
  APT repository.
- [`elgeeko1.apps.chromium`](roles/chromium/README.md): Installs the Chromium browser as a deb
  package from the xtradeb/apps PPA.
- [`elgeeko1.apps.docker`](roles/docker/README.md): Installs Docker Engine from the Docker APT
  repository, with optional multi-architecture builds.
- [`elgeeko1.apps.firefox`](roles/firefox/README.md): Installs Firefox as a deb package from the
  Mozilla Team PPA in place of the snap.
- [`elgeeko1.apps.kicad`](roles/kicad/README.md): Installs KiCad 9 from the KiCad releases PPA.
- [`elgeeko1.apps.remmina`](roles/remmina/README.md): Installs the Remmina remote desktop client
  with the FreeRDP plugin.
- [`elgeeko1.apps.slack`](roles/slack/README.md): Installs Slack from the Snap Store.
- [`elgeeko1.apps.spotify`](roles/spotify/README.md): Installs the Spotify client from the Spotify
  APT repository.
- [`elgeeko1.apps.tailscale`](roles/tailscale/README.md): Installs Tailscale and brings the node up
  with an auth key.
- [`elgeeko1.apps.vscode`](roles/vscode/README.md): Installs Visual Studio Code from the Microsoft
  APT repository, with extensions.
- [`elgeeko1.apps.zoom`](roles/zoom/README.md): Installs the Zoom client from the Zoom deb package.

## Release notes

[CHANGELOG.md](CHANGELOG.md) lists the changes in each release. Releases follow the
[versioning policy](https://github.com/elgeeko1/elgeeko1.linux#versioning) of the repository.

## License

MIT. See [LICENSE](LICENSE). Some roles include BSD-3-Clause portions, listed in the
`THIRD_PARTY_NOTICE.md` of each such role.
