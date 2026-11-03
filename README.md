# elgeeko1.linux Ansible collections

Collections for configuring common server and workstation applications and roles.

| Collection | Contents |
| -- | -- |
| [`elgeeko1.linux`](ansible_collections/elgeeko1/linux/README.md) | Baseline Debian and Ubuntu configuration. |
| [`elgeeko1.apps`](ansible_collections/elgeeko1/apps/README.md) | Desktop and developer applications. |
| [`elgeeko1.workstation`](ansible_collections/elgeeko1/workstation/README.md) | User workstation configuration. |

Each collection README lists its requirements, installation, and roles.

## Development

Install the Python tooling with [uv](https://docs.astral.sh/uv/), the collection dependencies, and
the pre-commit git hooks:

```bash
make config
```

Run every [pre-commit](.pre-commit-config.yaml) hook on every file: file hygiene, role README
tables, mdformat, markdownlint, lychee local link checks, ansible-lint with syntax-check, and
actionlint:

```bash
make lint
```

### Role documentation

The `meta/argument_specs.yml` of each role defines its variables, which ansible-core validates when
the role runs and `ansible-doc -t role` displays. [aar-doc](https://github.com/telekom-mms/aar_doc)
renders them into the table between the `BEGIN_ANSIBLE_DOCS` and `END_ANSIBLE_DOCS` markers of the
role README, with the template in [.aar_doc.yml](.aar_doc.yml). The pre-commit hook and CI fail when
a table is stale. Render every table:

```bash
make docs
```

### VS Code

[.vscode/settings.json](.vscode/settings.json) formats YAML and Markdown on save to match the
linters and runs the Ansible extension from the `make config` environment.
[.vscode/extensions.json](.vscode/extensions.json) lists the recommended extensions.

## Testing

Each role has a Molecule scenario under
`ansible_collections/elgeeko1/<collection>/extensions/molecule/<role>`. The base configuration in
[.config/molecule/config.yml](.config/molecule/config.yml) runs each scenario in a privileged
systemd container on amd64 Ubuntu 22.04, 24.04, and 26.04 and Debian 12 and 13, and converges as an
unprivileged sudo user. A scenario overrides `platforms` to test a subset of releases. Regular
testing covers amd64 only.

Run every scenario with `make test`, or run one scenario, or every scenario of a collection, from
the collection root:

```bash
cd ansible_collections/elgeeko1/apps
molecule test -s chrome
molecule test --all
```

### CI

| Workflow | Runs on | Checks |
| -- | -- | -- |
| [CI (all)](.github/workflows/ci-all.yml) | pushes to `main`, pull requests | quality checks, every scenario on every platform |
| [CI (quick)](.github/workflows/ci-quick.yml) | pushes to other branches without an open pull request | quality checks, every scenario on Ubuntu 26.04 |
| [Release](.github/workflows/release.yml) | `v*` tags | quality checks, every scenario on every platform, collection build |

The quality checks in [\_quality.yml](.github/workflows/_quality.yml) run ansible-lint,
markdownlint, lychee, actionlint, and mdformat, and fail on a stale role README table.

## Versioning

The three collections share one version and one release tag, `vX.Y.Z`, under
[Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- A major release may remove or rename a role or a role variable, change a default in a way that
  changes behavior, drop a platform release, or raise `requires_ansible`.
- A minor release may add roles, role variables, and platform releases, and deprecate features.
- A patch release fixes defects only.

A deprecation lands in a minor release, in the changelog and the role README, and the removal in the
next major release. Each collection records its changes in its `CHANGELOG.md`, in
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) form.

## Releasing

Set the version of every collection and turn each Unreleased changelog section into the release
section:

```bash
make release VERSION=X.Y.Z
```

Review and commit the change, then tag the commit and push the tag:

```bash
git tag -a vX.Y.Z -m vX.Y.Z
git push origin vX.Y.Z
```

The [release workflow](.github/workflows/release.yml) checks that every `galaxy.yml` version and
changelog section matches the tag and that a full release tag is on `main`, runs the quality checks
and every Molecule scenario on the tagged commit, and builds the collections. When all pass, it
creates the GitHub release with the collections attached. A tag with a hyphenated pre-release suffix
creates a pre-release.

## License

MIT. See [LICENSE](LICENSE). Roles with BSD-3-Clause portions list them in their
`THIRD_PARTY_NOTICE.md`.
