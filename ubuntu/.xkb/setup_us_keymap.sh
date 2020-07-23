#!/bin/bash

set -xue

xkbcomp \
  -I${HOME}/.xkb \
  -R${HOME}/.xkb \
  ${HOME}/.xkb/keymap/us_keymap \
  ${DISPLAY} \
  2> /dev/null

