#!/usr/bin/env python3

from pathlib import Path
import subprocess
import os
import sys


base_path = Path("/home/ivan/dotfiles/scripts/color_switcher/")
current_color_path = base_path / "current_color"

config_paths = {
    "sway": Path("/home/ivan/.config/sway/colors"),
    "waybar": Path("/home/ivan/.config/waybar/colors.css"),
    "kitty": Path("/home/ivan/.config/kitty/basic_colors.conf"),
    "wob": Path("/home/ivan/.config/wob/wob.ini"),
}


def replace_file(input_path, output_path):
    with open(input_path, 'r') as file:
        content = file.read()
    with open(output_path, 'w') as file:
        file.write(content)


def update_config(application: str,
                  color: str):

    input_path = Path(f"/home/ivan/scripts/color_switcher/global-colors/{application}_{color}")
    output_path = config_paths[application]
    replace_file(input_path, output_path)


def get_current_color():
    with open(current_color_path, 'r') as file:
        current_color = file.read().strip()
    return current_color

def update_color_file(current_color):
    with open(current_color_path, 'w') as file:
        file.write(current_color)


def get_keyboard_color(color: str):
    openrgb_color_path = base_path / f"global-colors/openrgb_{color}"
    with open(openrgb_color_path, 'r') as file:
        openrgb_color = file.read().strip()
    return openrgb_color

def get_keyboard_state(toggle: bool):
    keyboard_state_path = base_path / "keyboard_state"
    with open(keyboard_state_path, 'r') as file:
        keyboard_state = file.read().strip()
    if toggle:
        if keyboard_state == "on":
            keyboard_state = "off"
        else:
            keyboard_state = "on"
        with open(keyboard_state_path, 'w') as file:
            file.write(keyboard_state)
    return keyboard_state


def update_keyboard(color: str,
                    keyboard_state: str):
    if keyboard_state == "on":
        args = ['openrgb', '--noautoconnect', '-d', '0', '-c', '00ffff', '-m', 'breathing', '-b', '100']
    else:
        args = ['openrgb', '--noautoconnect', '-d', '0', '-m', 'off']
    subprocess.run(args)



def switch_colors(current_color: str):
    if current_color == "white":
        color = "red"
    else:
        color = "white"

    update_color_file(color)

    keyboard_color = get_keyboard_color(color)
    keyboard_state = get_keyboard_state(toggle=False)

    for application in config_paths.keys():
        update_config(application, color)
    subprocess.run(['swaymsg', 'reload'])
    subprocess.run(['killall',  '-SIGUSR1', 'kitty',])

    update_keyboard(color=keyboard_color,
                    keyboard_state=keyboard_state)


    


if __name__ == "__main__":
    args = sys.argv
    current_color = get_current_color()
    if args[1] == "-c":
        switch_colors(current_color)
    elif args[1] == "-k":
        keyboard_state = get_keyboard_state(toggle=True)
        update_keyboard(color=current_color, keyboard_state=keyboard_state)


