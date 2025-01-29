#! /usr/bin/bash
LOW_TEMP=68
HIGH_TEMP=85
MSI_MODULE_DIR=/sys/devices/platform/msi-ec/

echo "Setting shift mode to turbo..."
echo turbo | sudo tee $MSI_MODULE_DIR/shift_mode

while true; do
    cpu_temp=$(cat $MSI_MODULE_DIR/cpu/realtime_temperature)
    gpu_temp=$(cat $MSI_MODULE_DIR/gpu/realtime_temperature)
    cooler_boost_status=$(cat $MSI_MODULE_DIR/cooler_boost)

    if [[ $cpu_temp -ge $HIGH_TEMP ]] || [[ $gpu_temp -ge $HIGH_TEMP ]]; then
        echo $(date) | tee -a /home/ivan/gaming.log
        echo cpu_temp: $cpu_temp | tee -a /home/ivan/gaming.log
        echo gpu_temp: $gpu_temp | tee -a /home/ivan/gaming.log
        if [[ $cooler_boost_status == "on" ]]; then
            echo "cooler boost already enabled" | tee -a /home/ivan/gaming.log
        else
            echo "enabling cooler boost" | tee -a /home/ivan/gaming.log
            echo on | sudo tee $MSI_MODULE_DIR/cooler_boost
        fi
    fi

    if [[ $cpu_temp -le $LOW_TEMP ]] && [[ $gpu_temp -le $LOW_TEMP ]]; then
        echo $(date) | tee -a /home/ivan/gaming.log
        echo cpu_temp: $cpu_temp | tee -a /home/ivan/gaming.log
        echo gpu_temp: $gpu_temp | tee -a /home/ivan/gaming.log
        if [[ $cooler_boost_status == "off" ]]; then
            echo "cooler boost already disabled" | tee -a /home/ivan/gaming.log
        else
            echo "disabling cooler boost" | tee -a /home/ivan/gaming.log
            echo off | sudo tee $MSI_MODULE_DIR/cooler_boost
        fi
    fi

    sleep 5
done
