#!/bin/sh
# Text for battery widget.

path="/sys/class/power_supply/BAT0"
if [ -d "$path" ]; then
    capacity=$(cat "$path/capacity")
    case "$(cat "$path/status")" in
        Discharging)
            printf "  %i %%" "$capacity"
            ;;
        Charging)
            printf " 🗲 %i %%" "$capacity"
            ;;
        Full)
            printf "  %i %%" "$capacity"
            ;;
        *)
            printf "  %i %%" "$capacity"
            ;;
    esac
fi
