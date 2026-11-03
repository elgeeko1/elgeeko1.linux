# elgeeko1.linux

Baseline configuration for Debian and Ubuntu hosts.

## Requirements

- ansible-core 2.22 or later.
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, on the managed hosts. Ubuntu 22.04 support is
  deprecated. A role README names any narrower platform support.

## Installation

Install a release by its tag from the
[releases](https://github.com/elgeeko1/elgeeko1.linux/releases), replacing `vX.Y.Z`:

```bash
ansible-galaxy collection install "git+https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/linux,vX.Y.Z"
```

Or list it in a `requirements.yml`:

```yaml
collections:
  - name: https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/linux
    type: git
    version: vX.Y.Z
```

## Roles

- [`elgeeko1.linux.core`](roles/core/README.md): Baseline configuration for Debian and Ubuntu hosts.
- [`elgeeko1.linux.ubuntu`](roles/ubuntu/README.md): Baseline configuration for Ubuntu hosts.
- [`elgeeko1.linux.ubuntu_desktop_ux`](roles/ubuntu_desktop_ux/README.md): Usability changes for
  Ubuntu Desktop.

## Release notes

[CHANGELOG.md](CHANGELOG.md) lists the changes in each release. Releases follow the
[versioning policy](https://github.com/elgeeko1/elgeeko1.linux#versioning) of the repository.

## License

MIT. See [LICENSE](LICENSE). Some roles include BSD-3-Clause portions, listed in the
`THIRD_PARTY_NOTICE.md` of each such role.
