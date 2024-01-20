#!/bin/bash

mode=$1
toggle_blueman() {
    if pidof -x blueman-manager > /dev/null
    then
        killall blueman-manager
    else
        /usr/bin/blueman-manager
    fi
}

# toggle_bluetooth() {
#     bt_status="$(rfkill | grep bluetooth | awk '{print $4}')"
#     if [[ $bt_status == "blocked" ]]; then
#         rfkill unblock bluetooth
#     elif [[ $bt_status == "unblocked" ]]; then
#         rfkill block bluetooth
#     fi
# }

if [[ $mode == "client" ]]; then
    toggle_blueman
elif [[ $mode == "power" ]]; then
    sudo rfkill toggle bluetooth
fi

    

