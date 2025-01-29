#!/bin/bash
WAYBAR_DIR=$HOME/.config/waybar
eza $WAYBAR_DIR/config $WAYBAR_DIR/style.css | entr -rn waybar
