#!/bin/bash

mode=$1

declare -a output_list
declare -a output_status_list

get_outputs() {
	output_list=()
	output_status_list=()

	for output in $(swaymsg -t get_outputs | jq '.[].name'); do
		output_list+=($output)
	done

	for status in $(swaymsg -t get_outputs | jq '.[].active'); do
		output_status_list+=($status)
	done
}

activate_all_outputs() {
	get_outputs
	for i in ${!output_status_list[@]}; do
		is_active=${output_status_list[$i]}
		echo $is_active
		if [ $is_active == "false" ]; then
			swaymsg output ${output_list[$i]} enable
		fi
	done
}

automatic_config() {

	activate_all_outputs
	outputs=""
	for output in $(swaymsg -t get_outputs | jq '.[].name'); do
		outputs=$outputs"\n$output"
	done

	hdmi="$(echo -e $outputs | grep HDMI)"
	dp="$(echo -e $outputs | grep '\<DP')"
	edp="$(echo -e $outputs | grep 'eDP')"

	if [[ (-n $hdmi) && (-n $dp) ]]; then
		swaymsg output $hdmi pos 0 0 mode 1920x1080@60Hz transform 270
		swaymsg output $dp pos 1080 0 mode 2560x1440@165Hz adaptive_sync off
		swaymsg output $edp pos 3640 0 mode 1920x1080@240Hz
	elif [[ -n $dp ]]; then
		swaymsg output $edp pos 0 0 mode 1920x1080@240Hz
		swaymsg output $dp pos 1920 0 mode 2560x1440@165Hz adaptive_sync off
	elif [[ -n $hdmi ]]; then
		swaymsg output $edp pos 0 0 mode 1920x1080@240Hz
		swaymsg output $hdmi pos 1920 0 mode 1920x1080@60Hz transform 0
	else
		swaymsg output $edp pos 0 0 mode 1920x1080@240Hz
	fi
}

if [[ (-z $mode) ]]; then
	modes="auto\ngaming\ndual-gaming\nwork\nbattery-saver"
	mode=$(echo -e $modes | fuzzel -p "layout: " -d -f Iosevka)
fi

if [[ $mode == "auto" ]]; then
	automatic_config
elif [[ $mode == "gaming" ]]; then
	swaymsg output eDP-1 disable
	swaymsg output DP-1 enable
	swaymsg output DP-1 mode 2560x1440@165Hz pos 0 0 adaptive_sync on
elif [[ $mode == "dual-gaming" ]]; then
	activate_all_outputs
	swaymsg output eDP-1 pos 0 0 mode 1920x1080@240Hz
	swaymsg output DP-1 mode 2560x1440@165Hz pos 1920 0 adaptive_sync on
elif [[ $mode == "work" ]]; then
	activate_all_outputs
	swaymsg output eDP-1 pos 0 0 mode 1920x1080@240Hz
	swaymsg output DP-1 pos 1920 0 mode 2560x1440@165Hz adaptive_sync off
elif [[ $mode == "battery-saver" ]]; then
	get_outputs
	for output in $output_list; do
		if [[ ! ($output =~ "eDP-1") ]]; then
			swaymsg output $output disable
		fi
	done
	swaymsg output eDP-1 enable
	swaymsg output eDP-1 pos 0 0 mode 1920x1080@60Hz
fi
