#!/bin/sh

pidof dunst && killall dunst
dunst &

upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
lower="abcdefghijklmnopqrstuvwxyz"
digits="0123456789"

notify-send "HEAD" "$upper\n$lower\n$digits"
notify-send -u critical "HEAD" "$upper\n$lower\n$digits"
notify-send -u low "HEAD" "$upper\n$lower\n$digits"
