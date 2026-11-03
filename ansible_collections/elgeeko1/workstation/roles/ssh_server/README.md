# elgeeko1.workstation.ssh_server

Bootstraps SSH access for a user.

## Features

- Installs the OpenSSH client and creates `~/.ssh`.
- Generates an ed25519 keypair when none exists.
- Copies the public key to `keys/ssh` next to the playbook on the controller.
- Authorizes the public keys of a GitHub user.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `ansible.posix`, `community.crypto`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `ssh_server_user` | str | - | User that owns the keypair and the authorized keys; defaults to `ansible_user`, then `ansible_ssh_user`, then `$USER` on the controller. |
| `ssh_server_github_username` | str | - | GitHub user whose keys from `https://github.com/<user>.keys` are authorized; unset skips the import. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.workstation.ssh_server
      vars:
        ssh_server_github_username: octocat
```

## License

MIT. See [LICENSE](LICENSE).
