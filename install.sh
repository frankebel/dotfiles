#!/bin/sh
# Set up custom installation. Run this script after base installation is done.
# Configure packages/*.txt for packages to install.

host="$(uname -n)" # get hostname

# Host group: "" (none), "desktop" or "laptop"
case "$host" in
    *desktop*) group=desktop ;;
    *laptop*) group=laptop ;;
    *) group= ;;
esac

# Global config

# Copy /etc files
sudo cp -r etc /
[ "$group" = laptop ] && sudo cp -r laptop/etc /

# Install packages
# pacman
sudo pacman -Syu
cd packages || exit
# shellcheck disable=SC2024
[ -f pacman.txt ] && sudo pacman -S --needed - < pacman.txt
# shellcheck disable=SC2024
[ -f "pacman_$group.txt" ] && sudo pacman -S --needed - < "pacman_$group.txt"
cd ..
# AUR install with yay
cd packages || exit
if ! [ -x /usr/bin/yay ]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si
    cd .. || exit
    rm -rf yay
fi
[ -f aur.txt ] && yay -S --needed - < aur.txt
[ -f "aur_$group.txt" ] && yay -S --needed - < "aur_$group.txt"
cd ..

# systemd
sudo timedatectl set-ntp true
sudo systemctl enable cups.socket

# User config

# Julia
juliaup config channelsymlinks false
juliaup add release
juliaup add beta
juliaup default beta
julia -e 'using Pkg; Pkg.Apps.add("Runic")'
julia -e 'using Pkg; Pkg.Apps.add(url="https://github.com/aviatesk/JETLS.jl", rev="release")'
julia -e 'using Pkg; Pkg.Apps.add(url="https://github.com/aviatesk/TestRunner.jl", rev="release")'

# User and group management
sudo usermod -s /bin/zsh "$USER"

# create directories such that `stow` symlinks at the desired depth
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/gnupg
mkdir -p ~/.local/share/isync/mailbox
mkdir -p ~/.local/share/isync/tuw
mkdir -p ~/.local/share/pimsync/calendars
mkdir -p ~/.local/share/pimsync/contacts
mkdir -p ~/.local/share/pimsync/status
mkdir -p ~/.local/share/torrents
mkdir -p ~/.local/state/temp
mkdir -p ~/.ssh
chmod 700 ~/.local/share/gnupg
chmod 700 ~/.ssh

# create symblinks
stow --dir="$HOME/data/projects/dotfiles" --target="$HOME" home

# Remove bash files
rm ~/.bash*

systemctl enable --user goimapnotify@mailbox.service
systemctl enable --user goimapnotify@tuw.service
systemctl enable --user mailsync.timer
systemctl enable --user newsboat.timer
systemctl enable --user ssh-agent.service
systemctl enable --user syncthing.service
systemctl enable --user trash-empty.timer

# Finalize
printf '\033[1mCustom installation is done. Please reboot.\n'
