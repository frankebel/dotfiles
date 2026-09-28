#!/bin/sh

# environment variables, spack
# shellcheck source=/dev/null
[ -f ~/.bashrc ] && . ~/.bashrc

[ -x "$HOME/.local/bin/zsh" ] && exec "$HOME/.local/bin/zsh"
