#!/bin/sh

set -xue

name=$1

window=$(
  xdotool search --onlyvisible \
    --maxdepth 2 \
    --class "$name" \
  | tail -1
)

xdotool windowactivate $window

