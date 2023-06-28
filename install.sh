#!/bin/sh
# Set up custom installation. Run this script after base installation is done.
# Configure packages/*.txt for packages to install.

host="$(hostnamectl hostname)" # get hostname

# Global config

# Copy /etc files
sudo cp -r etc /

# Install packages
# pacman
sudo pacman -Syu
cd packages || exit
# shellcheck disable=SC2024
[ -f pacman.txt ] && sudo pacman -S --needed - < pacman.txt
case "$host" in
    *desktop*)
        # shellcheck disable=SC2024
        [ -f pacman_desktop.txt ] \
            && sudo pacman -S --needed - < pacman_desktop.txt
        ;;
    *laptop*)
        # shellcheck disable=SC2024
        [ -f pacman_laptop.txt ] \
            && sudo pacman -S --needed - < pacman_laptop.txt
        ;;
esac
cd ..
# AUR install with paru
cd packages || exit
if ! [ -x /usr/bin/paru ]; then
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg -si
    cd .. || exit
    rm -rf paru
fi
[ -f aur.txt ] && paru -S --needed - < aur.txt
case "$host" in
    *desktop*)
        [ -f aur_desktop.txt ] && paru -S --needed - < aur_desktop.txt
        ;;
    *laptop*)
        [ -f aur_laptop.txt ] && paru -S --needed - < aur_laptop.txt
        ;;
esac
cd ..

# systemd
sudo timedatectl set-ntp true
sudo systemctl enable cups.socket
case "$host" in
    *desktop*)
        sudo systemctl enable amdgpu-fan.service
        ;;
esac

# User config

# flexget inside virtual environment
mkdir -p ~/data/.environments
python -m venv ~/data/.environments/flexget
~/data/.environments/flexget/bin/pip install --upgrade pip
~/data/.environments/flexget/bin/pip install flexget transmission-rpc

# User and group management
sudo usermod -s /bin/zsh "$USER"
sudo usermod -aG libvirt "$USER"

# Create directories
mkdir -p ~/.config
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/gnupg
mkdir -p ~/.local/share/isync/mailbox
mkdir -p ~/.local/share/isync/tuw
mkdir -p ~/.local/share/torrents
mkdir -p ~/.local/state/temp
mkdir -p ~/.ssh
# Set directory permission
chmod 700 ~/.local/share/gnupg
chmod 700 ~/.ssh

# Why does "~" instead of "$HOME" cause errors in stow command?
stow home --dir="$HOME/.dotfiles" --target="$HOME" home

# Remove bash files
rm ~/.bash*

systemctl enable --user huewarm.timer
systemctl enable --user mailsync.timer
systemctl enable --user newsboat.timer
systemctl enable --user ssh-agent.service
systemctl enable --user syncthing.service
systemctl enable --user trash-empty.timer

# Finalize
printf '\033[1mCustom installation is done. Please reboot.\n'
