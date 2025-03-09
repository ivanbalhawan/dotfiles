#! /usr/bin/bash
LOW_TEMP=68
HIGH_TEMP=85
MSI_MODULE_DIR=/sys/devices/platform/msi-ec/

echo "Setting shift mode to turbo..."
echo turbo | sudo tee $MSI_MODULE_DIR/shift_mode
echo "Done!"

while true; do
    echo "Reading temperatures..."
    cpu_temp=$(cat $MSI_MODULE_DIR/cpu/realtime_temperature)
    gpu_temp=$(cat $MSI_MODULE_DIR/gpu/realtime_temperature)
    cooler_boost_status=$(cat $MSI_MODULE_DIR/cooler_boost)

    echo $(date)
    echo cpu_temp: $cpu_temp
    echo gpu_temp: $gpu_temp

    if [[ $cpu_temp -ge $HIGH_TEMP ]] || [[ $gpu_temp -ge $HIGH_TEMP ]]; then
        if [[ $cooler_boost_status == "on" ]]; then
            echo "cooler boost already enabled"
        else
            echo "enabling cooler boost"
            echo on | sudo tee $MSI_MODULE_DIR/cooler_boost
        fi

    elif [[ $cpu_temp -le $LOW_TEMP ]] && [[ $gpu_temp -le $LOW_TEMP ]]; then
        if [[ $cooler_boost_status == "off" ]]; then
            echo "cooler boost already disabled"
        else
            echo "disabling cooler boost"
            echo off | sudo tee $MSI_MODULE_DIR/cooler_boost
        fi
    else
        echo "No need to do anything"
    fi

    sleep 5;
done
