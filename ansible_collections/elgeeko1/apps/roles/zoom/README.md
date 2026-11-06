# elgeeko1.apps.zoom

Installs the Zoom client from the Zoom deb package.

## Features

- Downloads the Zoom deb to a cache directory of the connecting user and installs it. A pinned
  `zoom_version` downloads once; `latest` downloads on every run.
- Disables Zoom autostart on login.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `zoom_version` | str | `latest` | Zoom version in the download URL. |
| `zoom_disable_autostart` | bool | `true` | Disable Zoom autostart on login. |
| `zoom_download_dir` | str | - | Directory of the connecting user that keeps the downloaded Zoom deb; defaults to `~/.cache/elgeeko1.apps/zoom`. |

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
