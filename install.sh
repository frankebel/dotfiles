#!/bin/sh
# Set up custom installation. Run this script after base installation is done.
# Configure packages/*.txt for packages to install.

host="$(hostnamectl hostname)" # get hostname

# Global config

# Copy /etc files
rm /etc/security/pam_env.conf
sudo cp -r etc /
case "$host" in
    *laptop*)
        sudo cp -r laptop/etc /
        ;;
esac

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

# User config

# flexget inside virtual environment
mkdir -p ~/data/environments
uv venv ~/data/environments/flexget
# shellcheck disable=SC1090
. ~/data/environments/flexget/bin/activate
uv pip install flexget transmission-rpc
ln -s ~/data/environments/flexget/bin/flexget ~/.local/bin/flexget

# Julia
juliaup config channelsymlinks false
juliaup add release
julia -e 'using Pkg; Pkg.Apps.add("Runic")'
julia -e 'using Pkg; Pkg.Apps.add(url="https://github.com/aviatesk/TestRunner.jl")'

# User and group management
sudo usermod -s /bin/zsh "$USER"
sudo usermod -aG libvirt "$USER"

# Create directories
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
# Set directory permission
chmod 700 ~/.local/share/gnupg
chmod 700 ~/.ssh

# Why does "~" instead of "$HOME" cause errors in stow command?
stow home --dir="$HOME/.dotfiles" --target="$HOME" home

# Remove bash files
rm ~/.bash*

systemctl enable --user goimapnotify@mailbox.service
systemctl enable --user goimapnotify@tuw.service
systemctl enable --user huewarm.timer
systemctl enable --user mailsync.timer
systemctl enable --user newsboat.timer
systemctl enable --user ssh-agent.service
systemctl enable --user syncthing.service
systemctl enable --user trash-empty.timer

# Finalize
printf '\033[1mCustom installation is done. Please reboot.\n'
