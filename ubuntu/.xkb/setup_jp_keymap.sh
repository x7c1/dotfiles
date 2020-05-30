#!/bin/bash

xkbcomp -I${HOME}/.xkb -R${HOME}/.xkb ${HOME}/.xkb/keymap/jp_keymap ${DISPLAY} 2> /dev/null

