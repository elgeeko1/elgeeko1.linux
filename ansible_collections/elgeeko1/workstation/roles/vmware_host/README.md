# elgeeko1.workstation.vmware — VMWare configuration

This role configures a Linux host to run inside of a VMWare virtual machine.

## Features

- Installs open-vmware-tools
- Prevents network from hanging on startup.

## Role Variables

- `vmware_desktop_enabled`: Configure tools for a desktop environment.
  
  Default behavior: `false`
