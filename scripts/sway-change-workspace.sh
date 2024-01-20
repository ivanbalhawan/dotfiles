#!/bin/bash

direction=$1
next="$(echo $direction | grep next)"
current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | "\(.focused) \(.num)"' | grep true | awk '{print $2}')
if [[ -n $next ]]
then
    if [[ current_workspace -eq 10 ]]
    then
        next_workspace=1
    else
        next_workspace=$((current_workspace + 1))
    fi
else
    if [[ current_workspace -eq 1 ]]
    then
        next_workspace=10
    else
        next_workspace=$((current_workspace - 1))
    fi
fi

swaymsg workspace number $next_workspace
