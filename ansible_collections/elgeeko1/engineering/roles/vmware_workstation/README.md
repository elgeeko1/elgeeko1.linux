# elgeeko1.engineering.vmware_workstation

Installs VMware Workstation Pro on a Linux host, and builds and signs its `vmmon` and `vmnet` kernel
modules for the running kernel and for each kernel installed later.

## Features

- Copies the installer bundle from the controller to a cache directory of the connecting user and
  runs it unattended with `--console --required --eulas-agreed`. A rerun installs only a bundle
  whose build differs from the installed one.
- Installs build-essential and the headers of the running kernel, then builds `vmmon` and `vmnet`
  and restarts the `vmware` service.
- Installs `/usr/local/sbin/vmware-module-refresh`, which builds the modules for a kernel, and a
  `/etc/kernel/header_postinst.d` hook that runs it for each kernel whose headers APT installs.
- Under Secure Boot, creates a module signing key in `/var/lib/vmware-mok`, signs the modules with
  it, and queues its certificate for enrollment when `vmware_workstation_mok_password` is set.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Ubuntu 26.04 or 24.04, or Debian 13 or 12, amd64 hosts only.
- The VMware Workstation Pro installer for Linux, downloaded from the
  [Broadcom support portal](https://support.broadcom.com/) under its original file name, which ends
  in `-<build>.x86_64.bundle`.

## Secure Boot

The kernel loads the signed modules only after MokManager enrolls the signing certificate, which
takes a person at the console:

1. Apply the role with `vmware_workstation_mok_password`, or run
   `sudo mokutil --import /var/lib/vmware-mok/MOK.der` on the host.
1. Reboot. In the MokManager screen that shim shows before GRUB, select Enroll MOK, Continue, and
   Yes, enter the password, and reboot.

`sudo mokutil --test-key /var/lib/vmware-mok/MOK.der` prints `is already enrolled` once the
certificate is enrolled. Until then the role builds and signs the modules without restarting the
`vmware` service, which loads them at the next boot.

## After a kernel update

The header hook builds and signs the modules for each new kernel, so they load when that kernel
boots. To rebuild them for the running kernel, run the script, which refuses to restart the `vmware`
service while a virtual machine runs:

```bash
sudo vmware-module-refresh
```

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

| Variable | Type | Default | Description |
| -- | -- | -- | -- |
| `vmware_workstation_bundle` | str | required | Controller path of the VMware Workstation Pro installer, under its Broadcom file name ending in `-<build>.x86_64.bundle`. |
| `vmware_workstation_cache_dir` | str | - | Directory of the connecting user that keeps the copied installer; defaults to `~/.cache/elgeeko1.engineering/vmware_workstation`. |
| `vmware_workstation_mok_password` | str | - | One-time MokManager password that enrolls the module signing certificate at the next boot; unset leaves enrollment to the user. |

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.engineering.vmware_workstation
      vars:
        vmware_workstation_bundle: files/VMware-Workstation-Full-25.0.0-24995812.x86_64.bundle
```

## License

MIT. See [LICENSE](LICENSE).
