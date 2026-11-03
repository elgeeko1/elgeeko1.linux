# elgeeko1.workstation.terminal

Configures shell conveniences for a user.

## Features

- Grants the user passwordless sudo when `terminal_sudo_nopassword` is true.
- Adds an `update` alias.
- Marks symlinked directories with `/` in completion.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `terminal_user` | str | - | User whose sudo rights the role configures; defaults to `ansible_user`, then `ansible_ssh_user`, then `$USER` on the controller. |
| `terminal_sudo_nopassword` | bool | `false` | Grant `terminal_user` passwordless sudo; `false` leaves an existing grant in place. |

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
