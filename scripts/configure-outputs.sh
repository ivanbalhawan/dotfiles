#!/bin/bash

outputs=""
for output in $(swaymsg -t get_outputs | jq '.[].name')
do
    outputs=$outputs"\n$output"
done

hdmi="$(echo -e $outputs | grep HDMI)"
dp="$(echo -e $outputs | grep '\<DP')"
edp="$(echo -e $outputs | grep 'eDP')"

if [[ ( -n $hdmi ) && ( -n $dp ) ]]
then
    swaymsg output $hdmi pos 0 0 mode 1920x1080@60Hz transform 270
    swaymsg output $dp pos 1080 0 mode 2560x1440@165Hz adaptive_sync on
    swaymsg output $edp pos 3640 0 mode 1920x1080@240Hz
elif [[ -n $dp ]]
then
    swaymsg output $dp pos 0 0 mode 2560x1440@165Hz adaptive_sync on
    swaymsg output $edp pos 2560 0 mode 1920x1080@240Hz
elif [[ -n $hdmi ]]
then
    swaymsg output $edp pos 0 0 mode 1920x1080@240Hz
    swaymsg output $hdmi pos 1920 0 mode 1920x1080@60Hz transform 0
else
    swaymsg output $edp pos 0 0 mode 1920x1080@240Hz
fi
