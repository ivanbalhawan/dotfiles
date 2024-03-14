#!/bin/bash

sleep 0.05

if [[ $(dunstctl is-paused) == "false" ]]
then
    text="󰂚"
    class="notifications-active"
else
    text="󰂛"
    class="notifications-inactive"
fi

payload="{\"text\": \"$text\", \"tooltip\": \"\", \"percentage\": \"\", \"class\": \"$class\"}" 

echo $payload
