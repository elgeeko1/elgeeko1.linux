# elgeeko1.apps.slack

Installs Slack from the Snap Store.

## Features

- Installs the `slack` snap from the stable channel with classic confinement.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

None.

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.slack
```

## License

MIT. See [LICENSE](LICENSE).
