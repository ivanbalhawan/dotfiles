#!/bin/bash
if pidof gammastep > /dev/null
then
    kill "$(pidof gammastep)"
else
    /usr/bin/gammastep -O 3500K&
fi
