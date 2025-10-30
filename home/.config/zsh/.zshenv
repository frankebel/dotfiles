#!/bin/sh
# vim: filetype=sh

# Set PATH by editing `path` variable.
# See <https://zsh.sourceforge.io/Guide/zshguide02.html#l24>.
# shellcheck disable=SC3044
typeset -U path
# shellcheck disable=SC2206,SC3030
path=(~/.local/bin ~/.julia/bin $path)

# Load environment variables
# shellcheck source=/dev/null
. ~/.config/shell/environment
