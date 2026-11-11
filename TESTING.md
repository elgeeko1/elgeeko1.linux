# Testing

Each role has a Molecule scenario under
`ansible_collections/elgeeko1/<collection>/extensions/molecule/<role>`. The base configuration in
[.config/molecule/config.yml](.config/molecule/config.yml) runs each scenario in a privileged
systemd container on amd64 Ubuntu 22.04, 24.04, and 26.04 and Debian 12 and 13, and converges as an
unprivileged sudo user. A scenario overrides `platforms` to test a subset of releases. Regular
testing covers amd64 only.

Run the tests in the [development environment](CONTRIBUTING.md#development).

## Running tests

Run every scenario with `make test`, or run one scenario, or every scenario of a collection, from
the collection root:

```bash
cd ansible_collections/elgeeko1/apps
molecule test -s chrome
molecule test --all
```

## CI

| Workflow | Runs on | Checks |
| -- | -- | -- |
| [CI (all)](.github/workflows/ci-all.yml) | pushes to `main`, pull requests | quality checks, every scenario on every platform |
| [CI (quick)](.github/workflows/ci-quick.yml) | pushes to other branches without an open pull request | quality checks, every scenario on Ubuntu 26.04 |
| [Release](.github/workflows/release.yml) | `v*` tags | quality checks, every scenario on every platform, collection build |

The quality checks in [\_quality.yml](.github/workflows/_quality.yml) run ansible-lint,
markdownlint, lychee, actionlint, and mdformat, and fail on a stale role README table.
