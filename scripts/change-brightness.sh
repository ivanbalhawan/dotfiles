#!/bin/bash
# change-brightness

getCurrentBrightness() {
    brightnessctl -m | awk -F , '{print $4}' | sed 's/\%//'
}

displayBrightness() {
    current_brightness=$(getCurrentBrightness)
    dunstify -a "progressBar" -u low -h string:x-dunst-stack-tag:"Brightness" \
        -h int:value:${current_brightness} "Brightness: ${current_brightness}%"
    echo $current_brightness
}

command=$1
if [[ $command == "increase" ]]; then
    brightnessctl -q set 5%+
    current_brightness=$(getCurrentBrightness)
    ddcutil setvcp 10 $current_brightness --display 1
fi

if [[ $command == "decrease" ]]; then
    brightnessctl -q set 5%-
    current_brightness=$(getCurrentBrightness)
    ddcutil setvcp 10 $current_brightness --display 1
fi

displayBrightness
# dunstify -a "progressBar" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
#     -h int:value:"$volume" "$label ${volume}%"
