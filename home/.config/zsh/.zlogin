#!/bin/sh
# vim: filetype=sh

if [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi
