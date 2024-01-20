#!/bin/bash

if pidof pavucontrol > /dev/null
then
    kill "$(pidof pavucontrol)"
else
    /usr/bin/pavucontrol | xargs swaymsg exec --
fi

