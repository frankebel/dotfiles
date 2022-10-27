# Dotfiles

## Table of Contents
- [About](#about)
- [Installation and Setup](#installation-and-setup)
- [Software I use](#software-i-use)
- [Dependencies](#dependencies)
  - [Neovim](#neovim)
  - [Newsboat](#newsboat)
- [Explanation about software](#explanation-about-software)

## About
This repository contains my personal configuration files (dotfiles) which I manage with
[GNU Stow](https://www.gnu.org/software/stow/). Feel free to be inspired by them and use parts of it.
The color scheme I use is [dracula](https://draculatheme.com/).

- [home](home) contains dotfiles for my home directory.
- [desktop](desktop) contains dotfiles specific for my desktop setup.
- [laptop](laptop) contains dotfiles specific for my laptop setup.

## Installation and Setup
```sh
git clone https://github.com/frankebel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow home
```
optional:
```sh
stow desktop
stow laptop
```

## Software I use
| Type | Name | Repository | Files & Directories |
|---|---|---|---|
| Operating System | [Arch Linux](https://archlinux.org/) | [GitLab](https://gitlab.archlinux.org/archlinux) | |
| Display Server | [Xorg](https://www.x.org/wiki/) | | [x11](home/.config/x11) |
| Window Manager | [Awesome](https://awesomewm.org/) | [GitHub](https://github.com/awesomeWM/awesome/) | [awesome](home/.config/awesome) |
| Shell | [Zsh](https://www.zsh.org/) | [GitHub](https://github.com/zsh-users/zsh) | [zsh](home/.config/zsh) |
| Shell Prompt | [Starship](https://starship.rs/) | [GitHub](https://github.com/starship/starship) | [starship](home/.config/starship) |
| Terminal Emulator | [Alacritty](https://alacritty.org/) | [GitHub](https://github.com/alacritty/alacritty) | [alacritty](home/.config/alacritty) |
| Application Launcher | Rofi | [GitHub](https://github.com/davatorium/rofi) | [rofi](home/.config/rofi) |
| Color Scheme | [dracula](https://draculatheme.com/) | [GitHub](https://github.com/dracula/dracula-theme) | |
| Browser | [Firefox](https://www.mozilla.org/en-US/firefox/new/) | | |
| Editor | [Neovim](https://neovim.io/) | [GitHub](https://github.com/neovim/neovim) | [nvim](home/.config/nvim) |
| Font | [Noto Sans Mono](https://fonts.google.com/noto/specimen/Noto+Sans+Mono) | [GitHub](https://github.com/notofonts/noto-fonts) | |
| Image Viewer | [nsxiv](https://nsxiv.codeberg.page/) | [Codeberg](https://codeberg.org/nsxiv/nsxiv) | |
| Keyboard Shortcuts | sxhkd | [GitHub](https://github.com/baskerville/sxhkd) | [sxhkd](home/.config/sxhkd) |
| Mail | [Neomutt](https://neomutt.org/) | [GitHub](https://github.com/neomutt/neomutt) | [neomutt](home/.config/neomutt) |
| Mailbox Synchronization | [Isync](https://isync.sourceforge.io/) | | [isync](home/.config/isync) |
| Media Player | [mpv](https://mpv.io/) | [GitHub](https://github.com/mpv-player/mpv) | [mpv](home/.config/mpv) |
| Notifications | [Dunst](https://dunst-project.org/) | [GitHub](https://github.com/dunst-project/dunst) | [dunst](home/.config/dunst) |
| PDF Viewer | [zathura](https://pwmt.org/projects/zathura/) | [GitLab](https://git.pwmt.org/pwmt/zathura) | [zathura](home/.config/zathura) |
| Encryption | [GnuPG](https://gnupg.org/) | | [gnupg](home/.local/share/gnupg) |
| Password Manager | [pass](https://www.passwordstore.org/) | [Repo](https://git.zx2c4.com/password-store/) | |
| RSS Reader | [Newsboat](https://newsboat.org/) | | [newsboat](home/.config/newsboat) |
| Screenshots | [Flameshot](https://flameshot.org/) | [GitHub](https://github.com/flameshot-org/flameshot) | [flameshot](home/.config/flameshot) |

## Dependencies
The following programs are necessary to use my dotfiles fully:

### Neovim
- [autopep8](https://github.com/hhatto/autopep8)
- [flake8](https://flake8.pycqa.org/en/latest/)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [shellcheck](https://www.shellcheck.net/)
- [shfmt](https://github.com/mvdan/sh)
```sh
sudo pacman -S autopep8 flake8 ripgrep shellcheck shfmt
```

### Newsboat
- [mpv](https://mpv.io/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
```
sudo pacman -S mpv yt-dlp
```

## Explanation about software
If possible I try to follow the
[XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
For software which does not follow it, I try to export the environment variables in my [.zshenv](home/.config/zsh/.zshenv).

### Awesome
As my window manager (WM) I use [awesome](https://awesomewm.org/).
The help menu can be opened with the key combination `super + F1`.
Keybinds wich are WM-independent are set with [sxhkd](#sxhkd).
For the statusbar I have scripts running which are located in [.local/bin/statusbar](home/.local/bin/statusbar).

### GnuPG
I use [GnuPG](https://gnupg.org/) for encryption. I have a gpg-agent in the background running which caches my
password for 24 h. The settings are under [.local/share/gnupg](home/.local/share/gnupg).

### Isync
I use [isync](https://isync.sourceforge.io/) to synchronize my local mailbox using IMAP.
I have a script [mailsync](home/.local/bin/mailsync) which syncs my accounts and notifies me of incoming mail.
A systemd timer [mailsync.timer](home/.config/systemd/user/mailsync.timer)
and service file [mailsync.service](home/.config/systemd/user/mailsync.service) are used to run this program
automatically in the background.
For authentication I use [pass](#pass).

### Neomutt
For mail in the terminal I use [neomutt](https://neomutt.org/) set up with multiple accounts.
I can switch between accounts with the function keys (`F2` and following, as `F1` opens the manual).
For authentication I use [pass](#pass).

### Newsboat
[Newsboat](https://newsboat.org/) is my terminal RSS Reader of choice.
With `, + b` I can open links inside my browser;
with `, + v` inside my video player [mpv](https://mpv.io/).

### Neovim
I use [Neovim](https://neovim.io/) as my text editor.
User specific settings are set in [lua/user](home/.config/nvim/lua/user).
As my plugin manager I use [packer](https://github.com/wbthomason/packer.nvim) set up in
[plugins.lua](home/.config/nvim/lua/user/plugins.lua).
Most of the settings are set inside [after/plugin](home/.config/nvim/after/plugin).
After cloning the settings run `:PackerSync` inside neovim.

### Operating System
I use [Arch Linux](https://archlinux.org/) for my operating system as I like their simple and pragmatic approach.
I created an install script [archinstall](https://github.com/frankebel/archinstall) for faster setup.

### Pass
I use [pass](https://www.passwordstore.org/) and [pass-otp](https://github.com/tadfisher/pass-otp) to store 
and manage my passwords. It is set up as a git repository and each account lives inside an `gpg` encrypted file
(see [gnupg](#gnupg)) which makes version control very easy.
To quickly retrieve and enter my credentials, I use [rofi-pass](https://github.com/carnager/rofi-pass).

### Scripts
Scripts I use are in [.local/bin](home/.local/bin).
The directory [statusbar](home/.local/bin/statusbar) contains short scripts I use within [awesome](#awesome).

### Sxhkd
I use [sxhkd](https://github.com/baskerville/sxhkd) (simple X hotkey daemon) to manage my WM-independent 
keyboard shortcuts, which makes it easier to switch between window managers.
Most keybinds are started with the `super` key followed by a letter for my most used applications.
After that I bound some keys to control my microphone and speaker volume.
