#!/bin/sh
#
# apt full-upgrade that refuses to install a kernel whose pre-built NVIDIA
# modules would not come along. It simulates the upgrade first and checks that
# every linux-image-<abi> in the plan is matched by
# linux-modules-nvidia-<branch>-<abi>, either in the same plan or already
# installed. The driver branch comes from the installed meta package, so
# nothing is hard-coded. On a machine without the NVIDIA meta package this is
# a plain apt full-upgrade, still limited to the removals described below.
#
# It plans a full-upgrade rather than an upgrade because a driver point
# release breaks the pre-built modules of older kernels, which are pinned to
# the previous userspace version. Those modules have to be removed for the
# NVIDIA stack to move on, and neither `apt upgrade` nor unattended-upgrades
# ever removes a package, so the whole stack (and, with the lockstep, the
# kernel) stays held back. The only removals allowed are NVIDIA module
# packages of kernels other than the running one; that kernel then boots
# without the NVIDIA driver until it is removed. Any other removal stops the
# script so the plan can be reviewed by hand.
#
# Usage: apt-upgrade-safe [apt full-upgrade options, e.g. -y]

set -eu

sudo apt update

plan=$(apt-get -s full-upgrade 2>/dev/null)

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
  cat >&2 <<MSG

Refusing to upgrade: a new kernel would be installed without its NVIDIA modules.
Missing:$missing

The modules are probably not published for that kernel yet. Try again later,
or run 'sudo apt full-upgrade' yourself if you really want the kernel alone.
MSG
  exit 1
fi

running=$(uname -r)
allowed=""
unexpected=""
for pkg in $(printf '%s\n' "$plan" | sed -n 's/^Remv \([^ ]*\) .*/\1/p'); do
  case "$pkg" in
    linux-modules-nvidia-*-"$running")
      unexpected="$unexpected $pkg"
      ;;
    linux-modules-nvidia-*-[0-9]*-generic)
      allowed="$allowed $pkg"
      ;;
    *)
      unexpected="$unexpected $pkg"
      ;;
  esac
done

if [ -n "$unexpected" ]; then
  cat >&2 <<MSG

Refusing to upgrade: the upgrade would remove packages this script does not
remove on its own.
Would remove:$unexpected

Review the plan with 'apt-get -s full-upgrade' and run 'sudo apt full-upgrade'
yourself if the removals are fine.
MSG
  exit 1
fi

if [ -n "$allowed" ]; then
  cat >&2 <<MSG

The new NVIDIA driver no longer matches the modules of older kernels, so they
will be removed. Those kernels boot without the NVIDIA driver from now on.
Removing:$allowed

MSG
fi

sudo apt full-upgrade "$@"
