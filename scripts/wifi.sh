#!/bin/bash

connect_to_wifi() {
    nmcli device wifi rescan
    sleep 0.5
    SSID=$(nmcli -f IN-USE,SSID,bars device wifi list | awk 'NR!=1' | rofi -dmenu)
    SSID=$(echo "$SSID" | sed -r 's/^\*//' | sed 's/^\ *//')
    # SSID=$(echo $SSID | sed -r 's/(.*)\ [^\ ]*/\1/')
    SSID=$(echo $SSID | awk '{print $1}')
    sleep 0.5
    if [[ -n $SSID ]]; then
        nmcli connection up "$SSID" || nmcli device wifi connect "$SSID" || password=$(rofi -dmenu) && nmcli device wifi connect "$SSID" password "$password";
    fi
}

pkill rofi || connect_to_wifi
