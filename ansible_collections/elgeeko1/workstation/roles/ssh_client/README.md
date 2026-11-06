# elgeeko1.workstation.ssh_client

Configures the SSH client for a user.

## Features

- Creates `~/.ssh` and `~/.ssh/config.d`.
- Includes `config.d/*.config` and `config.d/**/*.config` from `~/.ssh/config`, so each host or
  project keeps its client configuration in its own file.

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
    - role: elgeeko1.workstation.ssh_client
```

## License

MIT. See [LICENSE](LICENSE).
