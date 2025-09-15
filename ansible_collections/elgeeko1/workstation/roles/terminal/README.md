# elgeeko1.workstation.terminal — common terminal configuration

This role configures common terminal niceties.

## Features

- Configures user for passwordless sudo
- Adds `update` bash alias
- Appends `/` to symmlink directories in `ls`

## Role Variables

- `terminal_server_user`: The remote user to use for user-scoped tasks.
  
  Default behavior: falls back to the current Ansible connection user (or the remote `$USER`).
