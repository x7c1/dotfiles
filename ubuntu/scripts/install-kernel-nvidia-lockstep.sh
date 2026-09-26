#!/bin/sh
#
# Stop unattended-upgrades from upgrading the kernel on its own on a machine
# that uses the pre-built NVIDIA modules. The kernel meta packages go on the
# unattended-upgrades blacklist, so the only way a new kernel image gets in
# automatically is as a dependency of linux-modules-nvidia-*-generic-hwe-*,
# in the same transaction as the modules built for it. When the NVIDIA
# stack is held back, the kernel waits with it instead of booting into a
# kernel without its GPU driver. Manual updates go through apt-upgrade-safe.

set -eu

if ! dpkg-query -W -f='${Package}\t${Status}\n' 'linux-modules-nvidia-*-generic-hwe-*' 2>/dev/null \
  | grep -q 'install ok installed$'
then
  echo "No pre-built NVIDIA module meta package installed; nothing to do."
  exit 0
fi

sudo install -m 644 /dev/stdin /etc/apt/apt.conf.d/51unattended-upgrades-nvidia <<'EOF'
// Installed by dotfiles/ubuntu/scripts/install-kernel-nvidia-lockstep.sh.
//
// Keep the kernel meta packages out of unattended-upgrades. A new kernel
// image then only arrives as a dependency of the NVIDIA module meta package,
// together with the modules built for it. Entries are Python regexps
// matched at the start of the package name.
Unattended-Upgrade::Package-Blacklist {
  "^linux-generic-hwe-";
  "^linux-image-generic-hwe-";
  "^linux-headers-generic-hwe-";
};
EOF

echo "Effective unattended-upgrades blacklist:"
apt-config dump Unattended-Upgrade::Package-Blacklist
