#!/bin/bash

profile=$(ls ~/.config/OpenRGB/ | grep ".orp" | sort | fuzzel -i Iosevka:size10 -d -p "rgb-profile: ")
openrgb -p $profile
