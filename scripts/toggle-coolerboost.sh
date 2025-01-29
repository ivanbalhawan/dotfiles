#! /usr/bin/bash
msi_ec_path='/sys/devices/platform/msi-ec';
current_mode=$(cat $msi_ec_path/cooler_boost)
# available_modes="on\noff";
# echo -e $available_modes | fzf | sudo tee $msi_ec_path/cooler_boost;
if [[ $current_mode == "off" ]]; then
    echo "on" | sudo tee $msi_ec_path/cooler_boost
else
    echo "off" | sudo tee $msi_ec_path/cooler_boost
fi
