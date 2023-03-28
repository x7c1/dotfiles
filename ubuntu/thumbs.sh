#!/bin/sh

set -xue

files=$@

height=2160
width=$(($height * 2 / 3))

feh -L '%w %h %f' $files \
  | awk '{ if ($1 < $2) { print $0 } }' \
  | cut -d ' ' -f 3- \
  | shuf \
  | tail -7 \
  | feh \
    --borderless \
    --thumbnails \
    --index-info '' \
    --image-bg white \
    --thumb-width $(($width - 5)) \
    --thumb-height $(($height - 5)) \
    --limit-height $(($height)) \
    --full-screen \
    --randomize \
    --filelist -

