#!/bin/sh

set -x
set -u
set -e

main() {
  setup_screen_saver
}

setup_screen_saver() {
  # https://askubuntu.com/questions/292995/configure-screensaver-in-ubuntu
  sudo apt-get remove gnome-screensaver

  sudo apt-get install -y \
    xscreensaver \
    xscreensaver-data-extra \
    xscreensaver-gl-extra
}

main

