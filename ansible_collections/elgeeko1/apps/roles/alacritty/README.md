# elgeeko1.apps.alacritty

Installs the Alacritty terminal emulator from the Snap Store with an optional tmux configuration.

## Features

- Installs the `alacritty` snap from the stable channel with classic confinement and deploys a
  configuration to `~/.config/alacritty`.
- Installs `tmux` and deploys `~/.tmux.conf`.
- Adds a `title` shell function that sets the tmux pane title, or the terminal title outside tmux,
  and clears the title when a shell starts.
- Adds a `~/.bashrc` line that unsets the `SNAP_*` variables exported by the Alacritty snap, so
  programs started from its shells do not detect themselves as snaps.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Collections: `community.general`

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `alacritty_config_template` | str | `alacritty.toml` | Template deployed to `~/.config/alacritty`; empty skips the deployment. |
| `alacritty_tmux_enabled` | bool | `true` | Install tmux and deploy its configuration. |
| `alacritty_tmux_config_template` | str | `tmux.conf` | Template deployed to `~/.tmux.conf`; empty skips the deployment. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.apps.alacritty
```

## License

MIT. See [LICENSE](LICENSE).
