#!/bin/sh

# environment variables
# shellcheck source=/dev/null
. ~/.config/shell/environment

# shellcheck source=/dev/null
[ -f ~/.bashrc ] && . ~/.bashrc

[ -x "$HOME/.local/bin/zsh" ] && exec "$HOME/.local/bin/zsh"
