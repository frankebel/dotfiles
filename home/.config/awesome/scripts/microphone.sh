#!/bin/sh
# Text for microphone widget.

case "$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)" in
    *MUTED*)
        printf "󰍭"
        ;;
    *)
        volume="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -Po '\d\.\d+')"
        volume="$(echo "$volume" | awk '{printf "%.0f", $1 * 100}')" # Convert to percentage
        printf "󰍬 %i %%" "$volume"
        ;;
esac
