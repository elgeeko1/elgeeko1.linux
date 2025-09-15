# elgeeko1.workstation.git — git Bootstrap

This role bootstraps git for a user on a Linux host.

## Features

- Installs git
- Generates a gpg key and configures git to sign commits with it
- Sets some sane git defaults

## Role Variables

- `git_github_username`: github username (used for git defaults and gpg key)
- `git_github_email`: github email address (used for git defaults and gpg key)
- `git_generate_gpg`: generate and use a gpg key for git commit signing

  Default: `true`

- `git_editor`: git default editor

  Default: `nano`
