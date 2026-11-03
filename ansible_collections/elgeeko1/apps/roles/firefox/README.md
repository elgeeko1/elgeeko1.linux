# elgeeko1.apps.firefox

Installs Firefox as a deb package from the Mozilla Team PPA in place of the snap.

## Features

- Adds the Mozilla Team PPA and pins it above the Ubuntu archive.
- Allows unattended upgrades from the PPA.
- Removes the Firefox snap and installs the `firefox` deb.
- Sets Firefox as the system and GNOME default browser.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Ubuntu hosts only.
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `firefox_set_default_browser` | bool | `true` | Set Firefox as the default browser. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.firefox
```

## License

MIT. See [LICENSE](LICENSE).
