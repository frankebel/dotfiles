#!/bin/sh

export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
[ -r "$ZDOTDIR/.zshenv" ] && . "$ZDOTDIR/.zshenv"
