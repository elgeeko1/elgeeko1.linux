# elgeeko1.workstation.desktop

Configures GNOME desktop preferences for a user.

## Features

- Shows an editable path in the Files toolbar instead of the folder buttons.
- Adds a `desktop` alias that starts the graphical target.
- Masks `systemd-networkd-wait-online`, so boot does not wait for the network.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

None.

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.workstation.desktop
```

## License

MIT. See [LICENSE](LICENSE).
