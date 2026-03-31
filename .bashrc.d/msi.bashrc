MSI_DIR='/sys/devices/platform/msi-ec/'
if [[ -d $MSI_DIR ]]; then
    shift_mode () {
        NEW_SHIFT_MODE=$(cat $MSI_DIR/available_shift_modes | fzf-smart)
        echo $NEW_SHIFT_MODE | sudo tee $MSI_DIR/shift_mode
    }

    fan_mode () {
        NEW_FAN_MODE=$(cat $MSI_DIR/available_fan_modes | fzf-smart)
        echo $NEW_FAN_MODE | sudo tee $MSI_DIR/fan_mode
    }
else
    echo nope
fi
