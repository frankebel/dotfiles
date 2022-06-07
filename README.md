# Dotfiles

This repository contains my configuration files (dotfiles).

* [default](default) contains dotfiles for all devices.
* [desktop](desktop) contains dotfiles specific for my desktop setup.
* [laptop](laptop) contains dotfiles specific for my laptop setup.

## Installation

```sh
git clone https://github.com/frankebel/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
stow default
```

optional:

```sh
stow desktop
stow laptop
```
