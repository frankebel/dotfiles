#!/bin/sh

# environment variables, spack
# shellcheck source=/dev/null
[ -f ~/.bashrc ] && . ~/.bashrc

# switch to zsh only in interactive shells
case $- in *i*) command -v zsh > /dev/null && exec zsh ;; esac
