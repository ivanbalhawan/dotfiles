#!/bin/bash


if pidof proton-mail-bridge > /dev/null
then
    thunderbird &
else
    proton-mail-bridge -n &
    thunderbird
fi



