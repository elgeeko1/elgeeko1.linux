# elgeeko1.apps.tailscale

Installs Tailscale and brings the node up with an auth key.

## Features

- Adds the Tailscale APT repository and installs `tailscale`.
- Enables and starts `tailscaled`.
- Stores the auth key in `/opt/tailscale/authkey` and runs `tailscale up --ssh` when the node is not
  running.

## Requirements

- The [collection requirements](../../README.md#requirements).

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `tailscale_auth_key` | str | `""` | Auth key written to `/opt/tailscale/authkey`; empty keeps the existing file. |
| `tailscale_up_extra_args` | str | `""` | Extra arguments for `tailscale up`. |

<!-- END_ANSIBLE_DOCS -->

The role fails when the node is not running and `/opt/tailscale/authkey` does not exist.

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.tailscale
```

## License

MIT. See [LICENSE](LICENSE).
