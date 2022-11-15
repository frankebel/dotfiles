#!/bin/sh
# vim: filetype=sh

[ "$(tty)" = '/dev/tty1' ] && exec startx "$XDG_CONFIG_HOME/x11/xinitrc"
