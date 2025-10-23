#!/bin/sh

# environment variables
# shellcheck source=/dev/null
. ~/.config/shell/environment

# Add directories to PATH
# juliaup
case "$PATH" in
    *juliaup/bin*) ;;
    *)
        PATH="$HOME/data/environments/juliaup/bin:${PATH}"
        ;;
esac
# ~/.local/bin
case "$PATH" in
    *.local/bin*) ;;
    *)
        PATH="$HOME/.local/bin:${PATH}"
        ;;
esac
export PATH

# shellcheck source=/dev/null
[ -f ~/.bashrc ] && . ~/.bashrc
