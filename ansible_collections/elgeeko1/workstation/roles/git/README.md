# elgeeko1.workstation.git

Configures git for a user, with an optional GPG signing key.

## Features

- Installs git and sets the user identity, editor, and pull and branch defaults.
- Generates an ed25519 GPG key and configures git to sign commits and tags.
- Copies the public GPG key to `keys/gpg` next to the playbook on the controller.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `git_github_username` | str | required | `user.name` and GPG key name. |
| `git_github_email` | str | required | `user.email` and GPG key email. |
| `git_generate_gpg` | bool | `true` | Generate a GPG key and sign commits and tags. |
| `git_editor` | str | `nano` | `core.editor`. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.workstation.git
      vars:
        git_github_username: octocat
        git_github_email: octocat@example.com
```

## License

MIT. See [LICENSE](LICENSE).
