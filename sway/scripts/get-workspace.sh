#! /bin/bash
# get currently focused output
focused_output=$(swaymsg -t get_outputs | jq -r 'map(pick(.name, .focused)) | map(select(.focused)) | .[0].name')
focused_workspace=$(swaymsg -t get_workspaces | jq -r 'map(select(.focused)) | .[0].name')
all_workspaces=$(swaymsg -t get_workspaces | jq '[.[].name] | map(tonumber) | sort')
output_workspaces=$(swaymsg -t get_workspaces | jq --arg o "$focused_output" 'map(select(.output == $o)) | [.[].name] | map(tonumber) | sort')

find_next_empty_workspace() {
    potential_workspaces=$(echo "1" | jq '[range(1;11)]')
    next_empty_workspace=$(echo $potential_workspaces | jq --argjson fw "$focused_workspace" --argjson a "$all_workspaces" 'map(select(. > $fw)) | map(select(. < 11)) | map(select([.] | inside($a) | not)) | min')
    if [[ $next_empty_workspace == "null" ]]; then
        next_empty_workspace=$(echo $output_workspaces | jq 'min')
    fi
    echo $next_empty_workspace
}


find_next_workspace_on_output() {
    next_workspace_on_output=$(echo $output_workspaces | jq --argjson fw "$focused_workspace" 'map(select(. > $fw)) | min')
    echo $next_workspace_on_output
}

find_next_workspace() {
    next_workspace=$(find_next_workspace_on_output)
    if [[ $next_workspace == "null" ]]; then
        next_workspace=$(find_next_empty_workspace)
    fi
    if [[ $next_workspace == "null" ]]; then
        next_workspace=$(echo $output_workspaces | jq 'min')
    fi
    echo $next_workspace
}

find_prev_empty_workspace() {
    potential_workspaces=$(echo "1" | jq '[range(1;11)]')
    prev_empty_workspace=$(echo $potential_workspaces | jq --argjson fw "$focused_workspace" --argjson a "$all_workspaces" 'map(select(. < $fw)) | map(select(. > 0)) | map(select([.] | inside($a) | not)) | max')
    if [[ $prev_empty_workspace == "null" ]]; then
        prev_empty_workspace=$(echo $output_workspaces | jq 'max')
    fi
    echo $prev_empty_workspace
}

find_prev_workspace_on_output() {
    prev_workspace_on_output=$(echo $output_workspaces | jq --argjson fw "$focused_workspace" 'map(select(. < $fw)) | max')
    echo $prev_workspace_on_output
}

find_prev_workspace() {
    prev_workspace=$(find_prev_workspace_on_output)
    if [[ $prev_workspace == "null" ]]; then
        prev_workspace=$(find_prev_empty_workspace)
    fi
    if [[ $prev_workspace == "null" ]]; then
        prev_workspace=$(echo $output_workspaces | jq 'max')
    fi
    echo $prev_workspace
}

direction=$1
type=$2
if [[ $type == "auto" ]]; then
    if [[ $direction == "next" ]]; then
        find_next_workspace
    elif [[ $direction == "prev" ]]; then
        find_prev_workspace
    fi
elif [[ $type == "empty" ]]; then
    if [[ $direction == "next" ]]; then
        find_next_empty_workspace
    elif [[ $direction == "prev" ]]; then
        find_prev_empty_workspace
    fi
fi


