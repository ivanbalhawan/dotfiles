#!/bin/bash

# fetch identifier
identifier=$(swaymsg -t get_inputs | jq -r '.[] | "\(.identifier) \(.type) \(.libinput.dwt)"' | grep touchpad | awk '{print $1}')
touchpad_state=$(swaymsg -t get_inputs | jq -r '.[] | "\(.identifier) \(.type) \(.libinput.dwt)"' | grep touchpad | awk '{print $3}')

if [[ $touchpad_state == "disabled" ]]
then
    swaymsg input $identifier dwt enabled;
    msg="DWT enabled";
else
    swaymsg input $identifier dwt disabled;
    msg="DWT disabled";
fi

dunstify -a "dwt" -u low -i touchpad-indicator $msg

