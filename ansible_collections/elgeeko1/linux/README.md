# elgeeko1.linux

Baseline configuration for Debian and Ubuntu hosts: Ansible prerequisites, APT upgrades, time sync,
and Ubuntu debloating.

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

- [`elgeeko1.linux.ansible_prereqs`](roles/ansible_prereqs/README.md): Installs Python 3 and the
  packages that Ansible modules require.
- [`elgeeko1.linux.apt_upgrade`](roles/apt_upgrade/README.md): Upgrades APT packages, with an
  optional Ubuntu archive snapshot, and reboots when required.
- [`elgeeko1.linux.time`](roles/time/README.md): Sets the timezone and runs ntpsec.
- [`elgeeko1.linux.ubuntu_debloat`](roles/ubuntu_debloat/README.md): Debloats Ubuntu: disables
  automatic updates and removes error reporting and the Ubuntu Pro client.
- [`elgeeko1.linux.ubuntu_debloat_desktop`](roles/ubuntu_debloat_desktop/README.md): Debloats Ubuntu
  Desktop: removes bundled apps, GNOME problem reports, and the update notifier.

## Release notes

[CHANGELOG.md](CHANGELOG.md) lists the changes in each release. Releases follow the
[versioning policy](https://github.com/elgeeko1/elgeeko1.linux#versioning) of the repository.

## License

MIT. See [LICENSE](LICENSE). Some roles include BSD-3-Clause portions, listed in the
`THIRD_PARTY_NOTICE.md` of each such role.
