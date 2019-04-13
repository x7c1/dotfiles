#!/bin/sh

set -eu

GOOGLE_DRIVE_TARGETS=$(
  findmnt --source google-drive-ocamlfuse --json |
  jq -r '.filesystems[].target'
)

if [ -z ${GOOGLE_DRIVE_TARGETS} ]; then
  echo "not mounted: google-drive-ocamlfuse"
else
  for target in ${GOOGLE_DRIVE_TARGETS}
  do
    echo "unmounting: ${target}"
    fusermount -u ${target}
  done
fi

echo "suspending..."
sleep 0.5
echo mem > /sys/power/state

