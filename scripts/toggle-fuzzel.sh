#!/bin/bash

if pidof fuzzel > /dev/null
then
    kill "$(pidof fuzzel)"
else
    /usr/bin/fuzzel --no-exit-on-keyboard-focus-loss
fi

