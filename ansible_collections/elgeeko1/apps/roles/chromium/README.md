# elgeeko1.apps.chromium

Installs the Chromium browser as a deb package from the xtradeb/apps PPA.

## Features

- Adds the xtradeb/apps PPA and installs `chromium`.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Ubuntu hosts only.

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

None.

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.chromium
```

## License

MIT. See [LICENSE](LICENSE).
