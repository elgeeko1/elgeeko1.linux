# elgeeko1.linux

Ansible roles for Debian and Ubuntu systems administration: a baseline configuration and Ubuntu
debloating for servers and workstations, common desktop applications, engineering tools with VMware
Workstation, and opinionated personal workstation preferences.

The roles ship as four collections in the `elgeeko1` namespace, installed from this repository
rather than from Ansible Galaxy:

| Collection | Contents |
| -- | -- |
| [`elgeeko1.linux`](ansible_collections/elgeeko1/linux/README.md) | Baseline Debian and Ubuntu configuration and Ubuntu debloating. |
| [`elgeeko1.apps`](ansible_collections/elgeeko1/apps/README.md) | Common desktop applications. |
| [`elgeeko1.engineering`](ansible_collections/elgeeko1/engineering/README.md) | Engineering tools: VS Code, KiCad, and VMware Workstation with Linux guests. |
| [`elgeeko1.workstation`](ansible_collections/elgeeko1/workstation/README.md) | Opinionated personal workstation preferences. |

## Requirements

- ansible-core 2.22 or later on the controller.
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, on the managed hosts. Ubuntu 22.04 support is
  deprecated. A role README names any narrower platform support.
- A remote user with sudo rights. The roles escalate privileges only for the tasks that need them.

## Installation

Install all four collections from a release tag on the
[releases](https://github.com/elgeeko1/elgeeko1.linux/releases) page, replacing `vX.Y.Z`.
`ansible-galaxy` also installs the Galaxy collections that they depend on:

```bash
ansible-galaxy collection install "git+https://github.com/elgeeko1/elgeeko1.linux.git#/ansible_collections/elgeeko1/,vX.Y.Z"
```

Or list them in the `requirements.yml` of your playbook repository:

```yaml
collections:
  - name: https://github.com/elgeeko1/elgeeko1.linux.git#/ansible_collections/elgeeko1/
    type: git
    version: vX.Y.Z
```

```bash
ansible-galaxy collection install -r requirements.yml
```

Each collection README shows how to install that collection alone.

## Usage

Reference a role by its fully qualified name. This inventory and playbook configure an Ubuntu
workstation:

```ini
[workstations]
desk01.example.com ansible_user=admin
```

```yaml
---
- name: Configure workstations
  hosts: workstations
  roles:
    - elgeeko1.linux.ansible_prereqs
    - elgeeko1.linux.apt_upgrade
    - elgeeko1.linux.ubuntu_debloat
    - elgeeko1.linux.ubuntu_debloat_desktop
    - elgeeko1.workstation.ssh_server
    - role: elgeeko1.workstation.git
      vars:
        git_github_username: octocat
        git_github_email: octocat@example.com
    - elgeeko1.apps.docker
```

Run the playbook, entering the sudo password of the remote user:

```bash
ansible-playbook -i inventory.ini site.yml --ask-become-pass
```

Each role validates its variables against its `meta/argument_specs.yml` before it runs. The role
README lists its features, requirements, and variables, and `ansible-doc` prints the variables of an
installed role:

```bash
ansible-doc -t role elgeeko1.workstation.git
```

## Roles

### elgeeko1.linux

| Role | Description |
| -- | -- |
| [`ansible_prereqs`](ansible_collections/elgeeko1/linux/roles/ansible_prereqs/README.md) | Python 3 and the packages that Ansible modules require. |
| [`apt_upgrade`](ansible_collections/elgeeko1/linux/roles/apt_upgrade/README.md) | Upgrades APT packages, with an optional Ubuntu archive snapshot, and reboots when required. |
| [`time`](ansible_collections/elgeeko1/linux/roles/time/README.md) | Sets the timezone and runs ntpsec. |
| [`ubuntu_debloat`](ansible_collections/elgeeko1/linux/roles/ubuntu_debloat/README.md) | Debloats Ubuntu: disables automatic updates and removes error reporting and the Ubuntu Pro client. |
| [`ubuntu_debloat_desktop`](ansible_collections/elgeeko1/linux/roles/ubuntu_debloat_desktop/README.md) | Debloats Ubuntu Desktop: removes bundled apps, GNOME problem reports, and the update notifier. |

### elgeeko1.apps

| Role | Description |
| -- | -- |
| [`1password`](ansible_collections/elgeeko1/apps/roles/1password/README.md) | 1Password and the 1Password CLI from the 1Password APT repository. |
| [`alacritty`](ansible_collections/elgeeko1/apps/roles/alacritty/README.md) | Alacritty terminal emulator, with an optional tmux configuration. |
| [`chrome`](ansible_collections/elgeeko1/apps/roles/chrome/README.md) | Google Chrome stable from the Google APT repository. |
| [`chromium`](ansible_collections/elgeeko1/apps/roles/chromium/README.md) | Chromium as a deb package from the xtradeb/apps PPA. |
| [`docker`](ansible_collections/elgeeko1/apps/roles/docker/README.md) | Docker Engine from the Docker APT repository, with optional multi-architecture builds. |
| [`firefox`](ansible_collections/elgeeko1/apps/roles/firefox/README.md) | Firefox as a deb package from the Mozilla Team PPA in place of the snap. |
| [`remmina`](ansible_collections/elgeeko1/apps/roles/remmina/README.md) | Remmina remote desktop client with the FreeRDP plugin. |
| [`slack`](ansible_collections/elgeeko1/apps/roles/slack/README.md) | Slack from the Slack APT repository. |
| [`spotify`](ansible_collections/elgeeko1/apps/roles/spotify/README.md) | Spotify client from the Spotify APT repository. |
| [`tailscale`](ansible_collections/elgeeko1/apps/roles/tailscale/README.md) | Tailscale, bringing the node up with an auth key. |
| [`zoom`](ansible_collections/elgeeko1/apps/roles/zoom/README.md) | Zoom client from the Zoom deb package. |

### elgeeko1.engineering

| Role | Description |
| -- | -- |
| [`kicad`](ansible_collections/elgeeko1/engineering/roles/kicad/README.md) | KiCad 9 from the KiCad releases PPA. |
| [`vmware_guest`](ansible_collections/elgeeko1/engineering/roles/vmware_guest/README.md) | Configures a Linux guest running in a VMware virtual machine. |
| [`vmware_workstation`](ansible_collections/elgeeko1/engineering/roles/vmware_workstation/README.md) | VMware Workstation Pro from an installer you supply, with its kernel modules built and signed for each kernel. |
| [`vscode`](ansible_collections/elgeeko1/engineering/roles/vscode/README.md) | Visual Studio Code from the Microsoft APT repository, with extensions. |

### elgeeko1.workstation

| Role | Description |
| -- | -- |
| [`desktop`](ansible_collections/elgeeko1/workstation/roles/desktop/README.md) | Configures GNOME desktop preferences for a user. |
| [`git`](ansible_collections/elgeeko1/workstation/roles/git/README.md) | Configures git for a user, with an optional GPG signing key. |
| [`passwordless_sudo`](ansible_collections/elgeeko1/workstation/roles/passwordless_sudo/README.md) | Grants a user passwordless sudo. |
| [`ssh_client`](ansible_collections/elgeeko1/workstation/roles/ssh_client/README.md) | Configures the SSH client for a user. |
| [`ssh_server`](ansible_collections/elgeeko1/workstation/roles/ssh_server/README.md) | Bootstraps SSH access for a user. |
| [`terminal`](ansible_collections/elgeeko1/workstation/roles/terminal/README.md) | Configures shell conveniences for a user. |

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

The four collections share one version and one release tag, `vX.Y.Z`, under
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
