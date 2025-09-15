# elgeeko1.apps.docker - install docker

## Features

- installs latest docker-ce
- installs docker python module
- installs docker-compose
- (optional) installs support for docker buildx multiarchitecture builds
- (optional) performs a docker system prune

## Role Variables

### multiarchitecture builds

- `docker_multiarch`: install QEMU.

  Default: `false`

- `docker_multiarch_containerd_snapshot`: use containerd-shapshot and create a buildx builder using the `docker-container` driver. Ignored if `docker_multiarch` is false.

  Default: `false`

- `docker_multiarch_containerd_builder_name`: docker buildx container name for multiarchitecture builds. Used only if `docker_multiarch` and `docker_multiarch_containerd_snapshot` are true.

  Default: `multiarch`

### Versions

- `docker_version`: version of docker-ce to install.

  Default: empty (latest)

- `docker_buildx_version`: version of docker-buildx-plugin to install.

  Default: empty (latest)

- `docker_compose_version`: version of docker-compose-plugin to install.

  Default: empty (latest)

- `docker_python_module_version`: version of python3-docker package to install.

  Default: empty (latest).

### Convenience

- `docker_prune`: prune docker containers, images and networks.

  Default: `false`

- `docker_add_user_to_docker_group`: Add current Ansible user to the docker group.

  Default: `true`
