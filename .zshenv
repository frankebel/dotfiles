# Default Apps
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export WM="qtile"
export READER="firefox"

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Manually settings paths for necessary programs.
# https://wiki.archlinux.org/title/XDG_Base_Directory
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/config.toml
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ZDOTDIR=$HOME/.config/zsh
export HISTFILE=$XDG_STATE_HOME/zsh/history

# disable fisle
export LESSHISTFILE=-
export QT_QPA_PLATFORMTHEME="qt5ct"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
