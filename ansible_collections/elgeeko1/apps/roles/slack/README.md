# elgeeko1.apps.slack

Installs Slack from the Slack APT repository.

## Features

- Adds the Slack APT repository as `slack.sources`, with its signing key in `/etc/apt/keyrings`, and
  installs `slack-desktop`.
- Sets `repo_add_once` and `repo_reenable_on_distupgrade` to `false` in `/etc/default/slack`, and
  keeps its other lines, so that the daily `slack-desktop` cron job adds no APT source or key. It
  removes the `slack.list` source and the `/etc/apt/trusted.gpg.d` keys that the job adds while
  either setting is `true`.
- Removes the `slack` snap from a host that has snapd.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

None.

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.slack
```

## License

MIT. See [LICENSE](LICENSE).
