# elgeeko1.linux.ansible_prereqs

Installs the packages that Ansible modules require on Debian and Ubuntu hosts.

## Features

- Installs Python 3 with pip, virtualenv, setuptools, psutil, python3-apt, and python3-debian.
- Installs sudo and acl, which let Ansible become an unprivileged user, and sshpass.
- Installs zip, unzip, gzip, curl, and wget for the archive and download modules.
- Installs jq and the AWS SDK for Python.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `ansible_prereqs_python_version` | str | - | `python3-dev` version, such as `3.12`; unset installs the candidate. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.linux.ansible_prereqs
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
