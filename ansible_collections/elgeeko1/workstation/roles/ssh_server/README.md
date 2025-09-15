# elgeeko1.workstation.ssh_server — SSH Key Bootstrap

This role bootstraps SSH access for a user on a Linux host.

## Features

- Installs OpenSSH client
- Creates ~/.ssh with secure permissions
- Generates an ed25519 keypair if missing
- Pulls the host’s public key back to the controller for inventory/ops
- Optionally imports GitHub public keys for a specified username into authorized_keys

## Role Variables

- `ssh_server_user`: The remote user who owns the SSH keypair and receives authorized keys.
  
  Default behavior: falls back to the current Ansible connection user (or the remote `$USER`).

- `ssh_server_github_username`: GitHub username whose keys (from `https://github.com/<user>.keys`) are authorized for ssh_server_user. If unset/empty or the fetch isn’t HTTP 200, this step is skipped.
