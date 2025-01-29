#! /bin/bash

bluetoothctl power on
bluetoothctl -t 3 scan on
device=$(bluetoothctl devices | wofi -d -l 5)
id=$(echo $device | awk '{print $2}')
bluetoothctl connect $id
