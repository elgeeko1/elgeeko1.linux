# elgeeko1.engineering.vscode

Installs Visual Studio Code from the Microsoft APT repository, with extensions.

## Features

- Adds the Microsoft APT repository as `vscode.sources`, with its signing key in
  `/etc/apt/keyrings`, and installs `code`.
- Answers the `code/add-microsoft-repo` debconf question with `false`, so that the `code` package
  adds no APT source or key. It removes the `vscode.list` source and the
  `/etc/apt/trusted.gpg.d/microsoft.gpg` key that `code` 1.100 and earlier add.
- Installs extensions for the desktop editor and for VS Code Server.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `vscode_version` | str | - | `code` package version; unset installs the candidate. |
| `vscode_extensions` | list of str | `[]` | Extension identifiers to install. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.engineering.vscode
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
