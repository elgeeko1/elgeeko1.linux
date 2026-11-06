# elgeeko1.linux.apt_upgrade

Upgrades APT packages on Debian and Ubuntu hosts.

## Features

- Updates the APT cache and installs aptitude, apt-transport-https, and ca-certificates.
- Configures an Ubuntu archive snapshot.
- Upgrades packages and removes packages that are no longer required.
- Reboots when `/var/run/reboot-required` exists, except on local connections.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `apt_upgrade_state` | str | `once` | When to upgrade APT packages; `once` upgrades on the first run on each host. One of `no`, `always`, `once`. |
| `apt_upgrade_snapshot` | str | - | Ubuntu archive snapshot in `YYYYMMDDTHHMMSSZ` form, such as `20230302T030400Z`; unset leaves snapshots unconfigured. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.linux.apt_upgrade
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
