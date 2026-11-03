# elgeeko1.linux.ubuntu

Baseline configuration for Ubuntu hosts.

## Features

- Trims the login message of the day.
- Disables unattended upgrades and the Ubuntu Pro ESM apt hook.
- Removes apport, whoopsie, and ubuntu-report.
- Removes the Ubuntu Pro client.
- Reboots when a change requires it.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `ubuntu_trim_motd` | bool | `false` | Remove the dynamic message of the day entries. |
| `ubuntu_disable_unattended_upgrades` | bool | `true` | Disable unattended upgrades. |
| `ubuntu_disable_error_reporting` | bool | `true` | Remove error reporting. |
| `ubuntu_disable_pro` | bool | `true` | Remove the Ubuntu Pro client. |

<!-- END_ANSIBLE_DOCS -->

## Dependencies

`elgeeko1.linux.core`, declared in `meta/main.yml`.

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.linux.ubuntu
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
