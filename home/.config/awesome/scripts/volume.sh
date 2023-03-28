#!/bin/sh
# Text for volume widget.

case "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)" in
    *MUTED*)
        printf "󰖁 "
        ;;
    *)
        volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -Po '\d\.\d+')"
        volume="$(echo "$volume" | awk '{printf "%.0f", $1 * 100}')" # Convert to percentage
        printf "󰕾 %i %%" "$volume"
        ;;
esac
