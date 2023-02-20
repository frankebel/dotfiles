#!/bin/sh
# vim: filetype=sh

[ "$(tty)" = "/dev/tty1" ] && exec startx
