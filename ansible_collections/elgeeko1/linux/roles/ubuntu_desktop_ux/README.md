# elgeeko1.linux.ubuntu_desktop_ux

Usability changes for Ubuntu Desktop.

## Features

- Removes gnome-initial-setup, LibreOffice, Rhythmbox, and Thunderbird.
- Disables GNOME technical problem reports and clears `/var/crash`.
- Removes the update notifier.
- Masks `systemd-networkd-wait-online`.
- Shows an editable path in the Files toolbar instead of the folder buttons.
- Adds a `desktop` alias that starts the graphical target.
- Reboots when a change requires it.

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
    - role: elgeeko1.linux.ubuntu_desktop_ux
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
