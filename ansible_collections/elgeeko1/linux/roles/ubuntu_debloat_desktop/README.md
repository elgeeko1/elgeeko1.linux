# elgeeko1.linux.ubuntu_debloat_desktop

Debloats Ubuntu Desktop: removes bundled apps, GNOME problem reports, and the update notifier. Pair
it with [`ubuntu_debloat`](../ubuntu_debloat/README.md).

## Features

- Removes gnome-initial-setup, LibreOffice, Rhythmbox, and Thunderbird.
- Disables GNOME technical problem reports and clears `/var/crash`.
- Removes the update notifier, the release upgrader, and unattended-upgrades.
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
    - role: elgeeko1.linux.ubuntu_debloat_desktop
```

## License

MIT. See [LICENSE](LICENSE). Portions are BSD-3-Clause; see
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md).
