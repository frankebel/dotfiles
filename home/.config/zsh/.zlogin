#!/bin/sh
# vim: filetype=sh

if [ "$(tty)" = "/dev/tty1" ]; then
    # Startup of programs which are independent of window manager.
    transmission-daemon &
    udiskie &
    case "$(hostnamectl hostname)" in
        *desktop*)
            ~/data/.environments/flexget/bin/flexget daemon start -d &
            ;;
    esac
    # Start compositor last
    exec Hyprland
fi
