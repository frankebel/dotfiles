# Dotfiles

## About
This repository contains my personal configuration files (dotfiles) which I mainly manage with
[GNU Stow](https://www.gnu.org/software/stow/). Feel free to be inspired by them and use parts of it.
The color scheme I use is [dracula](https://draculatheme.com).

- [home](home) contains dotfiles for my home directory.

## Installation and Setup
```sh
git clone https://github.com/frankebel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
Suggestions when asked for packages:
- jack: `pipewire-jack`
- pipewire-session-manager: `wireplumber`
- vulkan-driver: on AMD use `vulkan-radeon`

update dotfiles in home directory after basic installation:
```sh
stow home
```

## Software I use
| Type | Name | Repository | Files & Directories |
|---|---|---|---|
| Operating System | [Arch Linux](https://archlinux.org/) | [GitLab](https://gitlab.archlinux.org/archlinux) | |
| Display Server | [Wayland](https://wayland.freedesktop.org) | [GitLab](https://gitlab.freedesktop.org/wayland/wayland) | |
| Compositor | [Hyprland](https://hyprland.org) | [GitHub](https://github.com/hyprwm/Hyprland) | [hypr](home/.config/hypr) |
| Shell | [Zsh](https://www.zsh.org/) | [GitHub](https://github.com/zsh-users/zsh) | [zsh](home/.config/zsh) |
| Shell Prompt | [Starship](https://starship.rs/) | [GitHub](https://github.com/starship/starship) | [starship](home/.config/starship) |
| Terminal Emulator | [WezTerm](https://wezfurlong.org/wezterm/index.html) | [GitHub](https://github.com/wez/wezterm) | [wezterm](home/.config/wezterm) |
| Application Launcher | Wofi | [sourcehut](https://hg.sr.ht/~scoopta/wofi) | [wofi](home/.config/wofi) |
| Color Scheme | [dracula](https://draculatheme.com/) | [GitHub](https://github.com/dracula/dracula-theme) | |
| Browser | [Firefox](https://www.mozilla.org/en-US/firefox/new/) | | |
| Editor | [Neovim](https://neovim.io/) | [GitHub](https://github.com/neovim/neovim) | [nvim](home/.config/nvim) |
| Font | FiraCode | [GitHub](https://github.com/tonsky/FiraCode) | |
| Image Viewer | imv | [sourcehut](https://sr.ht/~exec64/imv/) | [imv](home/.config/imv) |
| Mail | [Neomutt](https://neomutt.org/) | [GitHub](https://github.com/neomutt/neomutt) | [neomutt](home/.config/neomutt) |
| Mailbox Synchronization | [Isync](https://isync.sourceforge.io/) | | [isync](home/.config/isync) |
| Media Player | [mpv](https://mpv.io/) | [GitHub](https://github.com/mpv-player/mpv) | [mpv](home/.config/mpv) |
| Notifications | [Dunst](https://dunst-project.org/) | [GitHub](https://github.com/dunst-project/dunst) | [dunst](home/.config/dunst) |
| PDF Viewer | [zathura](https://pwmt.org/projects/zathura/) | [GitLab](https://git.pwmt.org/pwmt/zathura) | [zathura](home/.config/zathura) |
| Encryption | [GnuPG](https://gnupg.org/) | | [gnupg](home/.local/share/gnupg) |
| Password Manager | [pass](https://www.passwordstore.org/) | [Repo](https://git.zx2c4.com/password-store/) | |
| RSS Reader | [Newsboat](https://newsboat.org/) | | [newsboat](home/.config/newsboat) |
| Screenshots | grim | [sourcehut](https://git.sr.ht/~emersion/grim) | |

## Dependencies
The following programs are necessary to use my dotfiles fully:

### Neovim
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
```sh
sudo pacman -S fd ripgrep
```

### Newsboat
- [mpv](https://mpv.io/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
```sh
sudo pacman -S mpv yt-dlp
```

## Explanation about software
If possible I try to follow the
[XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
For software which does not follow it, I try to export the environment variables in my [.zshenv](home/.config/zsh/.zshenv).

### GnuPG
I use [GnuPG](https://gnupg.org/) for encryption. I have a gpg-agent in the background running which caches my
password for 24 h. The settings are under [.local/share/gnupg](home/.local/share/gnupg).

### Hyprland
Since I like the tiling workflow, I use [Hyprland](https://hyprland.org) as my
wayland compositor.
For the statusbar I run [Waybar](https://github.com/Alexays/Waybar).

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
As I use [lazy.nvim](https://github.com/folke/lazy.nvim) as my package manager,
the list of installed plugins can be viewed in [lazy-lock.json](home/.config/nvim/lazy-lock.json).

### Operating System
I use [Arch Linux](https://archlinux.org/) for my operating system as I like their simple and pragmatic approach.
I created an install script [archinstall](https://github.com/frankebel/archinstall) for faster setup.

### Pass
I use [pass](https://www.passwordstore.org/) and [pass-otp](https://github.com/tadfisher/pass-otp) to store
and manage my passwords. It is set up as a git repository and each account lives inside an `gpg` encrypted file
(see [gnupg](#gnupg)) which makes version control very easy.
To quickly retrieve and enter my credentials, I use [tessen](https://github.com/ayushnix/tessen).

### Scripts
Scripts I use are in [.local/bin](home/.local/bin).
