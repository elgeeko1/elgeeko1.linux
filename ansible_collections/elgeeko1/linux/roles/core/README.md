# elgeeko1.linux.core

Baseline configuration for Debian and Ubuntu hosts.

## Features

- Creates `~/.cache` and `~/.ssh` with an include for `~/.ssh/config.d`.
- Updates the APT cache, configures an Ubuntu archive snapshot, and upgrades packages.
- Installs Python 3 and the packages that common Ansible modules require.
- Sets the timezone and runs ntpsec.
- Reboots when `/var/run/reboot-required` exists, except on local connections.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `core_target_user` | str | - | User that owns user-scoped files; defaults to `ansible_user`, then `ansible_ssh_user`, then `$USER` on the controller. |
| `core_timezone` | str | - | IANA timezone name, such as `America/Los_Angeles`; unset leaves the timezone unchanged. |
| `core_ntp_enabled` | bool | `true` | Install ntpsec and keep its service running. |
| `core_apt_upgrade_state` | str | `once` | When to upgrade APT packages; `once` upgrades on the first run on each host. One of `no`, `always`, `once`. |
| `core_python_version` | str | - | `python3-dev` version, such as `3.12`; unset installs the candidate. |
| `core_apt_snapshot` | str | - | Ubuntu archive snapshot in `YYYYMMDDTHHMMSSZ` form, such as `20230302T030400Z`; unset leaves snapshots unconfigured. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.linux.core
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
