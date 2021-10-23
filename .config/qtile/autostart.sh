#!/bin/sh
dunst &
redshift &
udiskie &

case "$(cat /proc/sys/kernel/hostname)" in
	*"desktop"*)
		# Desktop specific
		;;
	*"laptop"*)
		# Laptop specific
		blueman-applet &
		nm-applet &
		;;
	esac
