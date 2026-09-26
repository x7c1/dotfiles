#!/bin/sh
#
# apt upgrade that refuses to install a kernel whose pre-built NVIDIA modules
# would not come along. It simulates the upgrade first and checks that every
# linux-image-<abi> in the plan is matched by linux-modules-nvidia-<branch>-<abi>,
# either in the same plan or already installed. The driver branch comes from
# the installed meta package, so nothing is hard-coded. On a machine without
# the NVIDIA meta package this is a plain apt upgrade.
#
# Usage: apt-upgrade-safe [apt upgrade options, e.g. -y]

set -eu

sudo apt update

plan=$(apt-get -s upgrade --with-new-pkgs 2>/dev/null)

# e.g. linux-modules-nvidia-595-open, from linux-modules-nvidia-595-open-generic-hwe-26.04
prefixes=$(
  dpkg-query -W -f='${Package}\t${Status}\n' 'linux-modules-nvidia-*-generic-hwe-*' 2>/dev/null \
    | awk -F'\t' '$2 == "install ok installed" { sub(/-generic-hwe-.*/, "", $1); print $1 }' \
    | sort -u
)

missing=""
for abi in $(printf '%s\n' "$plan" | sed -n 's/^Inst linux-image-\([0-9][^ ]*\) .*/\1/p'); do
  for prefix in $prefixes; do
    module="$prefix-$abi"
    if printf '%s\n' "$plan" | grep -q "^Inst $module "; then
      continue
    fi
    if [ "$(dpkg-query -W -f='${Status}' "$module" 2>/dev/null)" = "install ok installed" ]; then
      continue
    fi
    missing="$missing $module"
  done
done

if [ -n "$missing" ]; then
  cat >&2 <<EOF

Refusing to upgrade: a new kernel would be installed without its NVIDIA modules.
Missing:$missing

The modules are probably not published for that kernel yet. Try again later,
or run 'sudo apt upgrade' yourself if you really want the kernel alone.
EOF
  exit 1
fi

sudo apt upgrade "$@"
