#!/bin/sh

# shellcheck source=/dev/null
[ -f /etc/bashrc ] && . /etc/bashrc

# Aliases
. ~/.config/shell/alias

alias ..='cd ..'

# No lsd installed
alias l='ls --almost-all --human-readable -l'
alias lt1='tree -L 1'
alias lt2='tree -L 2'
alias lt3='tree -L 3'
alias lt='tree'
