# Testing

Each role has a Molecule scenario under
`ansible_collections/elgeeko1/<collection>/extensions/molecule/<role>`. The base configuration in
[.config/molecule/config.yml](.config/molecule/config.yml) runs each scenario in a privileged
systemd container under rootless [Podman](https://podman.io/) on amd64 Ubuntu 22.04, 24.04, and
26.04 and Debian 12 and 13, and converges as an unprivileged sudo user. A scenario overrides
`platforms` to test a subset of releases. Regular testing covers amd64 only.

Run the tests as a regular user, in the [development environment](CONTRIBUTING.md#development).

## Running tests

`make test` runs each scenario once per platform, with at most `JOBS` runs at a time, or no limit
for `0`, and writes the output of each run to `.molecule/<collection>.<instance>/test.log`.
`scripts/molecule-test.sh --help` gives the default.

```bash
make test JOBS=1
```

To run one scenario, on every platform or on one, run Molecule from the collection root:

```bash
cd ansible_collections/elgeeko1/apps
molecule test -s chrome
molecule test -s chrome -p chrome-debian13
```

## Rootless Podman

Container root maps to a subordinate UID of the user who runs Molecule, so the kernel rejects
changes from a container to host state such as global sysctls, AppArmor policy, binfmt_misc, and the
clock. The prepare playbook fails a container whose root is host root.

Rootless Podman also counts the inotify instances of every container against
`fs.inotify.max_user_instances` of that user, and systemd in a container fails to boot once the
limit is reached. `JOBS` bounds the number of these containers that run at once.

## CI

| Workflow | Runs on | Checks |
| -- | -- | -- |
| [CI (all)](.github/workflows/ci-all.yml) | pushes to `main`, pull requests | quality checks, every scenario on every platform |
| [CI (quick)](.github/workflows/ci-quick.yml) | pushes to other branches without an open pull request | quality checks, every scenario on Ubuntu 26.04 |
| [Release](.github/workflows/release.yml) | `v*` tags | quality checks, every scenario on every platform, collection build |

The quality checks in [\_quality.yml](.github/workflows/_quality.yml) run ansible-lint,
markdownlint, lychee, actionlint, and mdformat, and fail on a stale role README table.
