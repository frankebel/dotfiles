# Load environment variables
# shellcheck source=/dev/null
. ~/.config/shell/environment

# Remove duplicates in PATH.
# See <https://zsh.sourceforge.io/Guide/zshguide02.html#l24>.
typeset -U path
