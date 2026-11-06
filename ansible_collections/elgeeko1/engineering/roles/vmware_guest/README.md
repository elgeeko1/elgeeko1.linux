# elgeeko1.engineering.vmware_guest

Configures a Linux guest running in a VMware virtual machine.

## Features

- Installs `open-vm-tools`.
- Installs `open-vm-tools-desktop` and disables the GNOME idle delay on desktop guests.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, hosts only.

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `vmware_guest_desktop_enabled` | bool | `false` | Configure the guest for a desktop session. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.engineering.vmware_guest
```

## License

MIT. See [LICENSE](LICENSE).
