#! /usr/bin/bash
current_output=$(swaymsg -t get_outputs | jq -r '.[].name' | fzf)
resolution=$(echo -e "3840x2160\n2560x1440\n1920x1080\ndisabled" | fzf)
if [[ $resolution == "disabled" ]]; then
    swaymsg output $output disable
else
    refresh_rates=$(swaymsg -t get_outputs | jq --arg current_output "$current_output" 'map(select(.name == $current_output)) | .[].modes | map(.refresh) | map(./1000) | unique | .[]')
    refresh_rate=$(echo -e "$refresh_rates" | fzf)
    swaymsg output $current_output mode ${resolution}@${refresh_rate}Hz
fi


