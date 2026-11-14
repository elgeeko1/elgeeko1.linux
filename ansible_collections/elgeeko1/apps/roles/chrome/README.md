# elgeeko1.apps.chrome

Installs Google Chrome stable from the Google APT repository.

## Features

- Adds the Google APT repository as `/etc/apt/sources.list.d/google-chrome.sources`, with its
  signing key in `/usr/share/keyrings/google-chrome.gpg`, and writes each file only when it is
  missing, since the `google-chrome-stable` package maintains both.
- Installs `google-chrome-stable`.

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
    - role: elgeeko1.apps.chrome
```

## License

MIT. See [LICENSE](LICENSE).
