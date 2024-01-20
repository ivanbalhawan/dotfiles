#!/bin/bash
# change-volume

device=$1
value=$2
is_source="$(echo $device | grep SOURCE)"
label="Volume"
if [[ -n $is_source ]]
then
    label="Microphone"
fi
msgTag="myvolume"
wpctl set-volume $device $value
volume="$(wpctl get-volume $device | awk '{print $2}' | sed 's/\.//' | sed 's/^0//')"
dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "$label ${volume}%"

if [[ -z $is_source ]]
then
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
fi
