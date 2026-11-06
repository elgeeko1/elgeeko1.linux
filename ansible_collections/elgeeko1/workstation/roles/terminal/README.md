# elgeeko1.workstation.terminal

Configures shell conveniences for a user.

## Features

- Adds an `update` alias.
- Marks symlinked directories with `/` in completion.

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
    - role: elgeeko1.workstation.terminal
```

## License

MIT. See [LICENSE](LICENSE).
