# elgeeko1.linux.ubuntu - common Ubuntu operations

This role is a standard configuration for Debian / Ubuntu systems.

## Features

- disables unattended upgrades
- disables error reporting
- disables Ubuntu Pro
- removes superflous messages of the day (motd)

## Role Variables

- `ubuntu_disable_unattended_upgrades`: Disable unattended upgrades?

  Default: `true`

- `ubuntu_disable_error_reporting`: Disable error reporting?

  Default: `true`

- `ubuntu_disable_pro`: Disable Ubuntu Pro?

  Default: `true`

- `ubuntu_trim_motd`: Trim MOTD to minimal messages?

  Default: `false`
