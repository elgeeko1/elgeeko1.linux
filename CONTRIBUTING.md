# Contributing

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

[TESTING.md](TESTING.md) covers the Molecule role tests and CI.

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
