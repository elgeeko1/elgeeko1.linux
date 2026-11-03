# elgeeko1.apps.docker

Installs Docker Engine from the Docker APT repository, with optional multi-architecture builds.

## Features

- Installs `docker-ce`, the CLI, rootless extras, and the buildx and compose plugins.
- Installs the Docker Python module.
- Adds the Ansible user to the `docker` group.
- Installs QEMU and a buildx builder for multi-architecture builds.
- Prunes containers, images, networks, volumes, and the build cache.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.docker`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `docker_multiarch` | bool | `false` | Install QEMU for multi-architecture builds. |
| `docker_multiarch_containerd_snapshot` | bool | `false` | Enable the containerd snapshotter and create a buildx builder with the `docker-container` driver; requires `docker_multiarch`. |
| `docker_multiarch_containerd_builder_name` | str | `multiarch` | Name of the buildx builder. |
| `docker_add_user_to_docker_group` | bool | `true` | Add `ansible_user` to the `docker` group. |
| `docker_prune` | bool | `false` | Prune containers, images, networks, volumes, and the build cache. |
| `docker_version` | str | - | `docker-ce`, `docker-ce-cli`, and `docker-ce-rootless-extras` version; unset installs the candidate. |
| `docker_buildx_version` | str | - | `docker-buildx-plugin` version; unset installs the candidate. |
| `docker_compose_version` | str | - | `docker-compose-plugin` version; unset installs the candidate. |
| `docker_python_module_version` | str | - | `python3-docker` version; unset installs the candidate. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.docker
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
