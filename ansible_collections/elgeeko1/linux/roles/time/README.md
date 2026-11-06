# elgeeko1.linux.time

Sets the timezone and runs NTP on Debian and Ubuntu hosts.

## Features

- Sets the timezone.
- Installs ntpsec and keeps its service running.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `time_timezone` | str | - | IANA timezone name, such as `America/Los_Angeles`; unset leaves the timezone unchanged. |
| `time_ntp_enabled` | bool | `true` | Install ntpsec and keep its service running. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.linux.time
      vars:
        time_timezone: America/Los_Angeles
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
