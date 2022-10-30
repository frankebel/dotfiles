# Add `$HOME/.local/bin` to `PATH`
typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

# Set default programs
# https://wiki.archlinux.org/title/Environment_variables#Default_programs
export BROWSER="firefox"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export VISUAL="nvim"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Manually setting environment variables for necessary software.
# https://wiki.archlinux.org/title/XDG_Base_Directory
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export ZDOTDIR="$HOME/.config/zsh"

# Uncategorized
export QT_QPA_PLATFORMTHEME="qt5ct" # Configure Qt 5 applications without desktop environment
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket" # `ssh-agent` setup with systemd user unit

# Less Colors for Man Pages
# export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
# export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
# export LESS_TERMCAP_me=$'\e[0m'           # end mode
# export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
# export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
# export LESS_TERMCAP_ue=$'\e[0m'           # end underline
# export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
