# elgeeko1.apps.spotify

Installs the Spotify client from the Spotify APT repository.

## Features

- Adds the Spotify APT repository as `/etc/apt/sources.list.d/spotify.list`, the file the
  `spotify-client` package maintains.
- Installs `spotify-client`.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Ubuntu 26.04 or 24.04 hosts only.

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

None.

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.spotify
```

## License

MIT. See [LICENSE](LICENSE).
