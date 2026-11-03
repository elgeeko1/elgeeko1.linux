# elgeeko1.apps.1password

Installs 1Password and the 1Password CLI from the 1Password APT repository.

## Features

- Adds the 1Password APT repository as `/etc/apt/sources.list.d/1password.sources`, the file the
  `1password` package maintains.
- Installs `1password` on x86_64 hosts and `1password-cli` on every host.

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
    - role: elgeeko1.apps.1password
```

## License

MIT. See [LICENSE](LICENSE).
