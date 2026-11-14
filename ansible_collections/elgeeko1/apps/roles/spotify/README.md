# elgeeko1.apps.spotify

Installs the Spotify client from the Spotify APT repository.

## Features

- Adds the Spotify APT repository as `/etc/apt/sources.list.d/spotify.list`, the file the
  `spotify-client` package maintains.
- Adds the current Spotify signing key to `/etc/apt/trusted.gpg.d`, where APT trusts it for every
  source without `Signed-By`. The `spotify-client` postinst copies each key that the package ships
  into that directory on every install and upgrade, with no setting to turn that off, so the role
  cannot limit the key to the Spotify repository.
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
