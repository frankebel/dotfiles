# Dotfiles

This repository contains my configuration files (dotfiles).

## Installation

```bash
echo 'alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"' >> $HOME/.bashrc
mkdir $HOME/.dotfiles
git clone --bare https://github.com/frankebel/dotfiles.git $HOME/.dotfiles
config checkout
config config status.showUntrackedFiles no
chsh -s /bin/zsh
```
