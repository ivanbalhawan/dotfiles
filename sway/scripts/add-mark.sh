#! /usr/bin/bash
new_mark=[\"$1\"]
criteria=$2
existing_marks=$(swaymsg -t get_marks | jq)

new_mark_exists=$(echo $new_mark | jq --argjson marks "$existing_marks" 'inside($marks)')
if [[ $new_mark_exists == "false" ]]; then
    swaymsg "$criteria mark --add $1"
fi
