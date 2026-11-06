#!/bin/sh
# Builds the VMware kernel modules for a kernel whose headers were just installed.
#
# run-parts passes the kernel release as the first argument. Exits without building once VMware
# Workstation is uninstalled, since vmware-modconfig is then absent.

set -o errexit
set -o nounset

[ -x /usr/bin/vmware-modconfig ] || exit 0

exec /usr/local/sbin/vmware-module-refresh --kernel "$1" --no-restart
