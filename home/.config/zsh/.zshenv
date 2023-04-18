#!/bin/sh
# vim: filetype=sh

# Add `$HOME/.local/bin` to `PATH`
[ "${PATH#"$HOME/.local/bin"}" = "$PATH" ] \
    && export PATH="$HOME/.local/bin:$PATH"

# XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

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
export TERM="wezterm"
export TERMINAL="wezterm"
export VISUAL="nvim"

# Manually set environment variables
# https://wiki.archlinux.org/title/XDG_Base_Directory
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export ZDOTDIR="$HOME/.config/zsh"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# fzf
export FZF_DEFAULT_COMMAND='fd --follow --unrestricted'
export FZF_DEFAULT_OPTS="--layout reverse --height 40% --multi \
--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 \
--bind ctrl-f:preview-down,ctrl-b:preview-up"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '[ -f {} ] \
&& bat --style=numbers --color=always {} \
|| tree -a -C -L 1 {}'"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_ALT_C_OPTS="--preview 'tree -a --gitignore -C -L 1 {}'"

# Uncategorized
export MANPAGER='nvim +Man!'        # use neovim as manpager
export QT_QPA_PLATFORMTHEME="qt5ct" # Configure Qt 5 applications without DE
# `ssh-agent` setup with systemd user unit
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
