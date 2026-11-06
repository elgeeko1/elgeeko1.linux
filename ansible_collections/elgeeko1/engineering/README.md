# elgeeko1.engineering

Engineering tools for Debian and Ubuntu hosts: VS Code, KiCad, and VMware Workstation with Linux
guests.

## Requirements

- ansible-core 2.22 or later.
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, on the managed hosts. Ubuntu 22.04 support is
  deprecated. A role README names any narrower platform support.

## Installation

Install a release by its tag from the
[releases](https://github.com/elgeeko1/elgeeko1.linux/releases), replacing `vX.Y.Z`:

```bash
ansible-galaxy collection install "git+https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/engineering,vX.Y.Z"
```

Or list it in a `requirements.yml`:

```yaml
collections:
  - name: https://github.com/elgeeko1/elgeeko1.linux.git#ansible_collections/elgeeko1/engineering
    type: git
    version: vX.Y.Z
```

## Roles

- [`elgeeko1.engineering.kicad`](roles/kicad/README.md): Installs KiCad 9 from the KiCad releases
  PPA.
- [`elgeeko1.engineering.vmware_guest`](roles/vmware_guest/README.md): Configures a Linux guest
  running in a VMware virtual machine.
- [`elgeeko1.engineering.vmware_workstation`](roles/vmware_workstation/README.md): Installs VMware
  Workstation Pro from an installer you supply, and builds and signs its kernel modules for each
  kernel.
- [`elgeeko1.engineering.vscode`](roles/vscode/README.md): Installs Visual Studio Code from the
  Microsoft APT repository, with extensions.

Apply `vmware_workstation` to the host, then `vmware_guest` to each Linux guest that the host runs.

## Release notes

[CHANGELOG.md](CHANGELOG.md) lists the changes in each release. Releases follow the
[versioning policy](https://github.com/elgeeko1/elgeeko1.linux#versioning) of the repository.

## License

MIT. See [LICENSE](LICENSE). Some roles include BSD-3-Clause portions, listed in the
`THIRD_PARTY_NOTICE.md` of each such role.
