#! /bin/bash

outputs=$(swaymsg -t get_outputs | jq -r '.[].name')
focused_output=$(swaymsg -t get_outputs | jq -r 'map(pick(.name, .focused)) | map(select(.focused)) | .[0].name')
workspaces_potential=$(echo "1" | jq '[range(1;11)]')

read_all_workspaces() {
    if [[ -z $1 ]]; then
        current_output=$focused_output
    else
        current_output=$1
    fi
    focused_workspace=$(swaymsg -t get_workspaces | jq -r 'map(select(.focused)) | .[0].name')
    workspaces_active_all=$(swaymsg -t get_workspaces | jq '[.[].name] | map(tonumber) | sort')
    workspaces_active_output=$(swaymsg -t get_workspaces | jq --arg o "$current_output" 'map(select(.output == $o)) | [.[].name] | map(tonumber) | sort')
    workspaces_active_other_outputs=$(swaymsg -t get_workspaces | jq --arg o "$current_output" 'map(select(.output != $o)) | [.[].name] | map(tonumber) | sort')
    workspaces_inactive=$(echo $workspaces_potential | jq --argjson a "$workspaces_active_all" 'map(select([.] | inside($a) | not))')
    workspaces_available_output=$(echo $workspaces_inactive $workspaces_active_output | jq -n '[inputs|.[]] | sort')
}

read_next_workspaces() {
    current_workspace_pointer=$1
    direction=$2
    if [[ $direction == "next" ]]; then
        empty_workspace=$(echo $workspaces_inactive | jq --argjson fw "$current_workspace_pointer" 'map(select(. > $fw)) | min')
        non_empty_workspace=$(echo $workspaces_active_output | jq --argjson fw "$current_workspace_pointer" 'map(select(. > $fw)) | min')
        wrap_workspace=$(echo $workspaces_active_output | jq 'min')
    else
        empty_workspace=$(echo $workspaces_inactive | jq --argjson fw "$current_workspace_pointer" 'map(select(. < $fw)) | max')
        non_empty_workspace=$(echo $workspaces_active_output | jq --argjson fw "$current_workspace_pointer" 'map(select(. < $fw)) | max')
        wrap_workspace=$(echo $workspaces_active_output | jq 'max')
    fi
}


reorganize_workspaces() {
    read_all_workspaces $focused_output
    min_empty_workspace=$(echo $workspaces_inactive | jq 'min')
    max_active_workspace=$(echo $workspaces_active_all | jq 'max')
    echo $min_empty_workspace
    echo $max_active_workspace
    # only reorganize if necessary
    if [[ $min_empty_workspace < max_active_workspace ]]; then
        for output in $outputs; do
            read_all_workspaces $output
            min_empty_workspace=$(echo $workspaces_inactive | jq 'min')
            min_next_active_workspace=$(echo $workspaces_active_output | jq --argjson pointer "$min_empty_workspace" 'map(select(. > $pointer)) | min')
            while [[ $min_next_active_workspace != "null" && $min_empty_workspace < $min_next_active_workspace ]]; do
                swaymsg rename workspace $min_next_active_workspace to $min_empty_workspace
                workspaces_active_output=$(swaymsg -t get_workspaces | jq --arg o "$output" 'map(select(.output == $o)) | [.[].name] | map(tonumber) | sort')
                min_next_active_workspace=$(echo $workspaces_active_output | jq --argjson pointer "$min_empty_workspace" 'map(select(. > $pointer)) | min')
                read_all_workspaces $output
                min_empty_workspace=$(echo $workspaces_inactive | jq 'min')
            done
        done
        read_all_workspaces $focused_output
    else
        echo "skipping reorganization"
    fi
}


select_next_workspaces() {
    direction=$1
    if [[ $direction == "next" ]]; then
        non_empty_workspace=$next_non_empty_workspace
        empty_workspace=$next_empty_workspace
    else
        non_empty_workspace=$prev_non_empty_workspace
        empty_workspace=$prev_empty_workspace
    fi
}

go_to_workspace() {
    read_next_workspaces $focused_workspace $1
    focused_workspace_repr=$(swaymsg -t get_workspaces | jq 'map(select(.focused)) | .[0].representation')
    position=$focused_workspace
    # echo "focused_workspace: $focused_workspace"
    # echo "$direction non-empty workspace: $non_empty_workspace"
    # echo "$direction empty workspace: $empty_workspace"
    # echo "$direction wrap workspace: $wrap_workspace"
    if [[ $focused_workspace_repr == "null" ]]; then
        if [[ $non_empty_workspace != "null" ]]; then
            # echo "Renaming workspace $focused_workspace to 11"
            # echo "Renaming workspace $non_empty_workspace to $position"
            # echo "Focusing workspace $position"

            swaymsg rename workspace $focused_workspace to 11
            swaymsg rename workspace $non_empty_workspace to $position
            swaymsg workspace $position
        else
            # wrap back to first active workspace on output
            # echo "Focusing workspace $wrap_workspace"
            swaymsg workspace $wrap_workspace
        fi
    else
        if [[ $non_empty_workspace != "null" ]]; then
            # go to next active workspace on output
            # echo "Focusing workspace $non_empty_workspace"
            swaymsg workspace $non_empty_workspace
        elif [[ $empty_workspace != "null" ]]; then
            # go to next empty workspace
            # echo "Focusing workspace $empty_workspace"
            swaymsg workspace $empty_workspace
        else
            # wrap back to first active workspace on output
            # echo "Focusing workspace $wrap_workspace"
            swaymsg workspace $wrap_workspace
        fi
    fi
}

move_window_to_workspace() {
    read_next_workspaces $focused_workspace $1
    focused_workspace_repr=$(swaymsg -t get_workspaces | jq 'map(select(.focused)) | .[0].representation')
    position=$focused_workspace
    if [[ $focused_workspace_repr == "null" ]]; then
        return
    fi
    if [[ $non_empty_workspace != "null" ]]; then
        # go to next active workspace on output
        # echo "Focusing workspace $non_empty_workspace"
        swaymsg move container to workspace $non_empty_workspace
    elif [[ $empty_workspace != "null" ]]; then
        # go to next empty workspace
        # echo "Focusing workspace $empty_workspace"
        swaymsg move container to workspace $empty_workspace
    else
        # wrap back to first active workspace on output
        # echo "Focusing workspace $wrap_workspace"
        swaymsg move container to workspace $wrap_workspace
    fi
}

reorganize_workspaces

action=$1
direction=$2
if [[ $action == "focus" ]]; then
    go_to_workspace $direction
elif [[ $action == "move" ]]; then
    move_window_to_workspace $direction
fi
