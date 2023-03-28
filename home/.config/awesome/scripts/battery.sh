#!/bin/sh
# Text for battery widget.

path="/sys/class/power_supply/BAT0"
if [ -d "$path" ]; then
    capacity=$(cat "$path/capacity")
    printf "  %s %%" "$capacity"
fi
