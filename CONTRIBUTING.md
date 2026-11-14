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

### Vendor APT repositories

Some vendor packages write their own APT source or signing key from a maintainer script or a cron
job. A role that installs one follows the pattern that matches what the package writes:

- The package writes, or an earlier version of it left, an unsigned source, a second source for the
  repository, or a key in `/etc/apt/trusted.gpg.d`, and has a setting that stops it from writing APT
  configuration: the role turns the setting off before the package installs, adds the repository
  with `ansible.builtin.deb822_repository` and `signed_by`, and removes those sources and keys. Its
  Molecule scenario recreates them before applying the role. See `slack` and `vscode`.
- The package writes a deb822 source under a fixed file name, with `Signed-By` naming a keyring of
  its own, and disables what its earlier versions wrote: the package owns the source. The role
  writes the source and keyring at the paths that the package uses, only when they are missing, so
  that the first install verifies. See `chrome` and `1password`.
- The package adds keys to `/etc/apt/trusted.gpg.d`, with no setting that stops it: the role README
  states that APT trusts those keys for every source without `Signed-By`. See `spotify`.

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
