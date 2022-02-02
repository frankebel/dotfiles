#!/bin/sh

sxhkd > /dev/null &
xmodmap -e "keycode  66 = BackSpace Escape BackSpace BackSpace BackSpace BackSpace BackSpace" &
