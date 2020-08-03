#!/bin/bash

set -x

# put this in /lib/systemd/system-sleep/
# (scripts in /etc/pm/sleep.d not working)
# rf. https://ubuntuforums.org/showthread.php?t=2340976

file_name=$(basename $0)
log=/tmp/"$file_name".log
version='0.0.3'

main() {
  {
    echo "-"
    echo "v$version $0"
    echo "launched at $(date)"
  } >> "$log"

  # rf. https://blog.christophersmart.com/2016/05/11/running-scripts-before-and-after-suspend-with-systemd/
  if [ "${1}" == "pre" ]; then
    on_pre
  elif [ "${1}" == "post" ]; then
    on_post
  else
    echo "somebody is calling me totally wrong." >> "$log"
  fi

  {
    echo "command: $0"
    echo "args: $*"
    echo "USER: $USER"
    echo "DISPLAY: $DISPLAY"
  } >> "$log"
}

on_pre() {
  echo "suspending..." >> "$log"
}

# rf. https://unix.stackexchange.com/questions/59623/custom-keyboard-layout-is-reset-to-default-on_post-standby-or-reboot
on_post() {
  echo "we are back!" >> "$log"

  for path in /home/*; do
    user=$(basename "$path")
    script="$path/.xkb/setup_us_keymap.sh"

    if [ -e "$script" ]; then
      echo "script found: $script" >> "$log"
      /bin/su - "$user" -c "sleep 3; DISPLAY=:1 $script" &
    else
      echo "not found: $script" >> "$log"
    fi
  done
}

main "$@"
