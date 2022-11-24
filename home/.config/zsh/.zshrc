# Aliases
source "$ZDOTDIR/aliases"

# Cursor shape
# Set shape depending on mode.
# shape list: https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html
function zle-keymap-select() {
    case $KEYMAP in
        vicmd)
            echo -ne '\e[2 q'
            ;;
        viins|main)
            echo -ne '\e[6 q'
            ;;
    esac
}
zle-line-init() {
    echo -ne '\e[6 q'
}
zle -N zle-keymap-select
zle -N zle-line-init

# Directory stack
# View stack with `dirs -v`.
# Navigate with `cd -n` with "n" being the number.
DIRSTACKSIZE="20"
setopt autopushd
setopt pushdignoredups
setopt pushdminus
setopt pushdsilent
setopt pushdtohome

# Completion
autoload -U compinit
setopt automenu
setopt magicequalsubst
zmodload zsh/complist
zstyle ':completion:*' menu select
 # order of completion
zstyle ':completion:*' completer _expand_alias _complete _approximate
zstyle ':completion:*' group-name '' # grouping results
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|=* l:|=*' # man zshcompwid
eval "$(dircolors)" # set LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
compinit
_comp_options+=(globdots) # include hidden files

# Editor
# Edit directly in "$EDITOR" by pressing 'v' in normal mode.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# History
[ -d "$XDG_STATE_HOME/zsh" ] || mkdir "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt incappendhistory
setopt histignoredups

# Keybinds
bindkey -v # vi mode
bindkey '^[[3~' delete-char # delete key. Find out with <^v + DELETE>.
bindkey -M menuselect '\e' send-break # <Esc>
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
export KEYTIMEOUT=1

# Prompt TODO 
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# man zshmisc

# Application Specific Settings
export GPG_TTY=$(tty) # GnuPG pinentry
eval "$(starship init zsh)" # Starship

# Plugins
plugindir='/usr/share/zsh/plugins'
source "$plugindir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$plugindir/zsh-autosuggestions/zsh-autosuggestions.zsh"
unset plugindir

# Uncategorized
setopt nobeep
setopt autocd

# fzf
source '/usr/share/fzf/completion.zsh'
source '/usr/share/fzf/key-bindings.zsh'
