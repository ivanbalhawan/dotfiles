#!/bin/bash

nmcli device wifi rescan
sleep 0.5
SSID=$(nmcli -f SSID,bars device wifi list | awk 'NR!=1' | fuzzel --log-level=none -d -f Iosevka)
SSID=$(echo $SSID | sed -r 's/(.*)\ [^\ ]*/\1/')
if [[ $SSID != '' ]]; then
    nmcli device wifi connect "$SSID" || password=$(fuzzel --password -d -l 0) && nmcli device wifi connect "$SSID" password "$password"
fi
