#!/bin/bash
CONFIG_FILES='/home/ivan/.config/waybar/config\n/home/ivan/.config/waybar/style.css'
killall waybar ; waybar &
echo -e "${CONFIG_FILES}" | entr bash -c 'killall waybar ; waybar'
