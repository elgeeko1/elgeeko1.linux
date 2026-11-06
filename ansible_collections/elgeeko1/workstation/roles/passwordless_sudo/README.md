# elgeeko1.workstation.passwordless_sudo

Grants a user passwordless sudo.

## Features

- Writes a rule to `/etc/sudoers.d/<user>` that lets the user run any command as any user without a
  password.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `passwordless_sudo_user` | str | - | User granted passwordless sudo; defaults to `ansible_user`, then `ansible_ssh_user`, then `$USER` on the controller. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.workstation.passwordless_sudo
```

## License

MIT. See [LICENSE](LICENSE).
