#!/bin/sh
# Setup of hyprland that is device specific

case "$(hostnamectl hostname)" in
    *laptop*)
        hyprctl keyword input:kb_layout us,us
        hyprctl keyword input:kb_variant colemak,altgr-intl
        blueman-applet &
        ;;
    *tuwien*)
        hyprctl keyword input:kb_layout us,us
        hyprctl keyword input:kb_variant colemak,altgr-intl
        ;;
esac
