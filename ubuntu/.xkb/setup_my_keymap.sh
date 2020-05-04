#!/bin/bash

if [ -s ${HOME}/.xkb/keymap/my_keymap ]
then
    sleep 1

    # cannot get ${DISPLAY} after suspend
    #xkbcomp -I${HOME}/.xkb -R${HOME}/.xkb ${HOME}/.xkb/keymap/my_keymap ${DISPLAY} 2> /dev/null
    xkbcomp -I${HOME}/.xkb -R${HOME}/.xkb ${HOME}/.xkb/keymap/my_keymap :1
fi

