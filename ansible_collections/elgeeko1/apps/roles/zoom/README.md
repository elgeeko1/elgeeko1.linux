# elgeeko1.apps.zoom

Installs the Zoom client from the Zoom deb package.

## Features

- Downloads and installs the Zoom deb.
- Disables Zoom autostart on login.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `zoom_version` | str | `latest` | Zoom version in the download URL. |
| `zoom_disable_autostart` | bool | `true` | Disable Zoom autostart on login. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.zoom
```

## License

MIT. See [LICENSE](LICENSE).
