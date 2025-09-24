# elgeeko1.apps.alacritty - install alacritty

## Features

- installs alacritty
- (optional) installs a sane default configuration

## Role Variables

### multiarchitecture builds

- `alacritty_config_template`: Alacritty configuration template file to deploy from the controller.

  Default: use `alacritty.toml` from this role.

#### tmux

- `alacritty_tmux_enabled`: configure Alacritty to use tmux.

  Default: `true`.

- `alacritty_tmux_config_template`: tmux configuration template file to deploy from the controller.

  Default: use `tmux.conf` from this role.
