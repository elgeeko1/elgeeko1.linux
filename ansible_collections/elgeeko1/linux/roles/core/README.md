# elgeeko1.linux.core - common Linux operations

This role is a standard configuration for Debian / Ubuntu systems.

## Features

- apt updates and package management
- python3
- timezone configuration
- prerequisites for common Ansible modules

## Role Variables

- `core_target_user`: The target use to use for user-scoped tasks.

  Default: the value of `ansible_user`, `ansible_ssh_user` or `ansible_env.USER` (whichever evaluates first).

- `core_timezone`: Timezone to set.

  Default: empty (do not set).

- `core_ntp_enabled`: Install and start NTP service.

  Default: `true`

- `core_apt_upgrade_state`: Upgrade packages? Otherwise install packages only if not present.

  Default: `"once"` to upgrade once per host.
  
  Values: `"once", "always", "no"`.

- `core_python_version`: Version of Python3 package to install.

  Default: empty (latest).

- `core_apt_snapshot`: Snapshot to use for ubuntu archives. Follows `YYYYMMDDTHHMMSSZ` format, for example `20230302T030400Z` for 03:04 UTC on 2 March 2023.

  Default: empty (do not configure snapshots).
