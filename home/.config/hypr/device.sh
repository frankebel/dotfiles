#!/bin/sh
# Setup of hyprland that is device specific

case "$(hostnamectl hostname)" in
    *desktop*)
        ~/data/.environments/flexget/bin/flexget daemon start -d &
        ;;
    *laptop*)
        hyprctl keyword input:kb_layout us,us
        hyprctl keyword input:kb_variant colemak,altgr-intl
        blueman-applet &
        nm-applet &
        ;;
    *tuwien*)
        hyprctl keyword input:kb_layout de,
        hyprctl keyword input:kb_variant nodeadkeys,
        ;;
esac
