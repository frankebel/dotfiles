#!/bin/sh
# Setup of hyprland that is device specific

case "$(hostnamectl hostname)" in
    *desktop*)
        hyprctl keyword monitor DP-1,preferred,2560x0,auto
        hyprctl keyword monitor DP-2,preferred,0x0,auto
        ~/data/.environments/flexget/bin/flexget daemon start -d &
        ;;
    *laptop*)
        hyprctl keyword input:kb_layout us,de
        hyprctl keyword input:kb_variant colemak,
        blueman-applet &
        nm-applet &
        ;;
    mint22)
        hyprctl keyword monitor DP-1,preferred,1920x0,auto
        hyprctl keyword monitor HDMI-A-1,preferred,0x0,auto
        hyprctl keyword input:kb_layout de,
        hyprctl keyword input:kb_variant nodeadkeys,
        ;;
esac
