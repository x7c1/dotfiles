#!/bin/bash

file_name=$(basename $0)
log=/tmp/"$file_name".log
version='0.0.6'

{
  echo "-"
  echo "v$version $0"
  echo "launched at $(date)"
} >> "$log"

{
  echo "  command: $0"
  echo "  args: $*"
  echo "  USER: $USER"
  echo "  HOME: $HOME"
  echo "  DISPLAY: $DISPLAY"
} >> "$log"

sleep 3

xkbcomp \
  -I${HOME}/.xkb \
  -R${HOME}/.xkb \
  ${HOME}/.xkb/keymap/us_keymap \
  ${DISPLAY} \
  2> /dev/null

