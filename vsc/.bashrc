#!/bin/sh

HISTSIZE=10000

# shellcheck source=/dev/null
[ -f /etc/bashrc ] && . /etc/bashrc
. ~/.config/bash/completion.bash
. ~/.config/bash/key-bindings.bash

# Aliases
. ~/.config/shell/alias

alias ..='cd ..'

# No lsd installed
alias l='ls --almost-all --human-readable -l'
alias lt1='tree -L 1'
alias lt2='tree -L 2'
alias lt3='tree -L 3'
alias lt='tree'

# load spack and module environment
[ -f /opt/spack/share/spack/setup-env.sh ] && . /opt/spack/share/spack/setup-env.sh

# Application Specific Settings
GPG_TTY="$(tty)"
export GPG_TTY
