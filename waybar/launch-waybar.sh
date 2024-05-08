#!/bin/bash
CONFIG_FILES="/home/ivan/.config/waybar/config /home/ivan/.config/waybar/style.css"
killall waybar
trap "killall waybar" EXIT
while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
