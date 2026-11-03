# elgeeko1.workstation

User workstation configuration for Debian and Ubuntu hosts.

## Requirements

- ansible-core 2.22 or later.
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, on the managed hosts. Ubuntu 22.04 support is
  deprecated. A role README names any narrower platform support.

## Installation

Install a release by its tag from the
[releases](https://github.com/elgeeko1/elgeeko1.linux/releases), replacing `vX.Y.Z`:

```bash
ansible-galaxy collection install "git+https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/workstation,vX.Y.Z"
```

Or list it in a `requirements.yml`:

```yaml
collections:
  - name: https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/workstation
    type: git
    version: vX.Y.Z
```

## Roles

- [`elgeeko1.workstation.git`](roles/git/README.md): Configures git for a user, with an optional GPG
  signing key.
- [`elgeeko1.workstation.ssh_server`](roles/ssh_server/README.md): Bootstraps SSH access for a user.
- [`elgeeko1.workstation.terminal`](roles/terminal/README.md): Configures shell conveniences for a
  user.
- [`elgeeko1.workstation.vmware_guest`](roles/vmware_guest/README.md): Configures a Linux guest
  running in a VMware virtual machine.

## Release notes

[CHANGELOG.md](CHANGELOG.md) lists the changes in each release. Releases follow the
[versioning policy](https://github.com/elgeeko1/elgeeko1.linux#versioning) of the repository.

## License

MIT. See [LICENSE](LICENSE).
