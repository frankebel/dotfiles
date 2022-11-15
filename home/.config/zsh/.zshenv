#!/bin/sh
# vim: filetype=sh

# Add `$HOME/.local/bin` to `PATH`
[ "${PATH#"$HOME/.local/bin"}" = "$PATH" ] \
    && export PATH="$HOME/.local/bin:$PATH"

# Commonly used directories
export DATADIR="$HOME/data"
export DOTDIR="$HOME/.dotfiles"
export MASTERDIR="$DATADIR/education/master"
export PROGRAMMINGDIR="$DATADIR/programming"
export TEMPDIR="$XDG_STATE_HOME/temp"
export TORRENTDIR="$XDG_DATA_HOME/torrents"

# Default programs
# https://wiki.archlinux.org/title/Environment_variables#Default_programs
export BROWSER="firefox"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export VISUAL="nvim"

# Manually set environment variables
# https://wiki.archlinux.org/title/XDG_Base_Directory
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export ZDOTDIR="$HOME/.config/zsh"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Uncategorized
export MANPAGER='nvim +Man!' # use neovim as manpager
export QT_QPA_PLATFORMTHEME="qt5ct" # Configure Qt 5 applications without DE
# `ssh-agent` setup with systemd user unit
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
