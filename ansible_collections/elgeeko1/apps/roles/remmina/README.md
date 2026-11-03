# elgeeko1.apps.remmina

Installs the Remmina remote desktop client with the FreeRDP plugin.

## Features

- Installs `remmina`, `remmina-plugin-rdp`, and the FreeRDP X11 and Wayland clients.
- Sets the Remmina host key to Left Ctrl in `/etc/xdg/remmina/remmina.pref`.

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
    - role: elgeeko1.apps.remmina
```

## License

MIT. See [LICENSE](LICENSE).
