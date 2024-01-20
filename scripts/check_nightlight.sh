#!/bin/bash

sleep 0.05

if pidof gammastep > /dev/null
then
    class="active"
else
    class=""
fi

payload="{\"text\": \"󱩍\", \"tooltip\": \"\", \"percentage\": \"\", \"class\": \"$class\"}" 

echo $payload
