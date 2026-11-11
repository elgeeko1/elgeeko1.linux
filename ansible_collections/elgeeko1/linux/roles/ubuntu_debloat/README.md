# elgeeko1.linux.ubuntu_debloat

Debloats Ubuntu hosts: disables automatic updates and removes error reporting and the Ubuntu Pro
client. Pair it with [`ubuntu_debloat_desktop`](../ubuntu_debloat_desktop/README.md) on Ubuntu
Desktop.

## Features

- Disables unattended upgrades, the Ubuntu Pro ESM apt hook, and Ubuntu Pro apt news.
- Removes apport, whoopsie, and ubuntu-report.
- Removes the Ubuntu Pro client.
- Trims the login message of the day and masks `motd-news.timer` when `ubuntu_debloat_trim_motd` is
  true.
- Reboots when a change requires it.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `ubuntu_debloat_trim_motd` | bool | `false` | Remove the dynamic message of the day entries. |
| `ubuntu_debloat_disable_unattended_upgrades` | bool | `true` | Disable unattended upgrades. |
| `ubuntu_debloat_disable_error_reporting` | bool | `true` | Remove error reporting. |
| `ubuntu_debloat_disable_pro` | bool | `true` | Remove the Ubuntu Pro client. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.linux.ubuntu_debloat
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
