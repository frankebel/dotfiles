# Zotero 10 keyring notes

Findings from 2026-09-17.
State at the time of writing: nothing installed or changed,
Zotero shows the keyring notice at every launch.

## Problem

Zotero 10 stores sync credentials through Mozilla's OSKeyStore,
which on Linux uses libsecret and therefore needs an `org.freedesktop.secrets` provider.
This machine has none, so the keystore write fails.

Verified in `/usr/lib/zotero/app/omni.ja` (zotero-bin 10.0.2):

- `xpcom/osKeyStore.js`: `alertMigrateFailed()` shows the notice once per run,
  so it returns on every launch until a provider exists.
- `xpcom/sync/syncLocal.js` `getAPIKey()`: the legacy plaintext API key is preferred and kept
  even after a successful migration ("so a downgrade can still read it").
  Only `setAPIKey()` drops it, which runs when the account is linked again.
- `_saveAPIKey()`: when the keystore is unusable and the sync is not a background one,
  the "Save Anyway" dialog stores the key unencrypted and no notice follows.
- The KB page linked from the dialog: <https://www.zotero.org/support/kb/linux_keyring>.

Zero-package path, about 2 minutes:
Settings, Account tab, Unlink Account (keep data), link again, click "Save Anyway".
The key stays unencrypted, which is its state today anyway, and the notice stops.

## System facts

- Login on tty1 through `login` (PAM service `login`), no display manager.
  `~/.config/zsh/.zlogin` execs `start-hyprland`.
- `~/.config/hypr/autostart.lua` runs
  `dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP`.
- `systemctl --user show-environment` already has `PASSWORD_STORE_DIR`, `GNUPGHOME`,
  `DISPLAY`, `WAYLAND_DISPLAY`, `XDG_CURRENT_DESKTOP`
  (from `~/.config/environment.d/60-environment.conf`).
- pass store: `~/.local/share/pass`, git-tracked, `.gitignore` holds only `temp.gpg`.
- `GNUPGHOME=~/.local/share/gnupg`, `gpg-agent.conf`:
  `pinentry-program /usr/bin/pinentry-curses`, both cache TTLs 86400.
  `gpg-agent.socket` is active.
- With a display present, the `/usr/bin/pinentry` wrapper tries gnome3, gtk, qt, curses, tty
  in that order.
  `pinentry-gnome3` lacks `libgcr-base-3.so.1`, so the wrapper would land on `pinentry-gtk`.
- Installed and relevant: libsecret, gtk3, gtk4, qt6-base, rustup, yay,
  chromium, discord, thunderbird (all look for a Secret Service).
  Not installed: any keyring, gcr, gcr-4, keepassxc.
- Zotero profile: `~/.zotero/zotero/4yqnukpu.default/`,
  `prefs.js` holds only `extensions.zotero.sync.server.username`,
  no WebDAV settings.

## Providers of `org.freedesktop.secrets`

Official repos (<https://archlinux.org/packages/?q=org.freedesktop.secrets>):

| Package       | Notes                                                              |
| ------------- | ------------------------------------------------------------------ |
| gnome-keyring | 3.3 MiB plus gcr and gcr-4, about 10 MiB total, PAM module, mature |
| oo7           | 30 MiB, no deps, Rust, `pam_oo7.so`, conflicts with gnome-keyring  |
| kwallet       | Qt 6 plus about ten KDE Frameworks libs, ksecretd, no upside here  |
| keepassxc     | 31 MiB, must be running, needs a hand-written D-Bus autostart file |
| chipass       | 28 MiB Qt password manager, same category as KeePassXC             |

AUR bridges to an existing store:
pass-secret-service (source 0.7.1, `-bin` 0.7.0, `-git`), pass-secrets-git (stale, 2024),
gopass-secret-service, 1password-secret-service, goldwarden and bitw for Bitwarden,
rook for a headless KeePass database, himitsu-secret-service, rosec, noirpass.
noirpass is GPG-backed but uses its own store, not pass.

Arch wiki pages read: GNOME/Keyring, oo7, KDE Wallet, KeePass, pass.
The Pass page does not mention Secret Service at all.

## Recommendation for a pass user: pass-secret-service

Upstream: <https://github.com/grimsteel/pass-secret-service>.
AUR: <https://aur.archlinux.org/packages/pass-secret-service>, maintainer nathawat.
The PKGBUILD builds from the pinned tag with a b2sum, `cargo build --frozen`,
and runs `cargo test`.

Why it fits:

- Honors `PASSWORD_STORE_DIR`, `PASSWORD_STORE_GPG_OPTS`, `PASSWORD_STORE_UMASK`,
  and shells out to `gpg`, so `GNUPGHOME` and gpg-agent apply unchanged.
- Package installs `org.freedesktop.secrets.service` (D-Bus activation)
  and a systemd user unit `pass-secret-service.service`,
  so Zotero's first request starts it.
- Writes into `secret-service/` inside the store: a `Default` collection,
  one `.gpg` file per secret, and `collections.redb` with unencrypted labels.
- Serves the `default` alias, which Mozilla's libsecret code asks for.
  Reads pass `can_prompt = true`, so gpg may run pinentry.
  There is no lock support: gpg is the gatekeeper.

Due diligence (measured on the clone and the GitHub API):

| Signal                   | Value                                            |
| ------------------------ | ------------------------------------------------ |
| First commit             | 2024-07-16                                       |
| Commits, releases        | 82, 11 (v0.3.0 2025-06 to v0.7.1 2026-06-29)     |
| Stars, forks             | 79, 13                                           |
| Contributors             | owner 74 commits, 6 others, 8 PR authors         |
| Code                     | 3742 lines of Rust, 1 unsafe block, no build.rs  |
| Processes spawned        | gpg, gpgconf, gpg-connect-agent only             |
| Network code             | none (tokio without `net`, no HTTP crate)        |
| Crates                   | 22 direct, 202 locked                            |
| Security bug history     | DH shared-secret padding bug, issue 23, Apr 2026 |
| AUR source package votes | 2, submitted 2025-09-16, no comments             |

The padding bug corrupted Electron safeStorage keys.
Fixed within three days, released in v0.7.1 two months later.
`pass-secret-service-bin` still ships 0.7.0, so build the source package.
Open issue 25 (enumeration via `SearchItems({})`) applies to every Secret Service provider.

Risks that remain:
bus factor of one, a daemon with standing power over the store while the gpg cache is warm,
and 202 crates of supply chain.
Worst case for Zotero is re-linking the account.

Steps, about 10 minutes:

1. `yay -S pass-secret-service`
2. In `~/.local/share/gnupg/gpg-agent.conf` set `pinentry-program /usr/bin/pinentry`,
   then `gpgconf --kill gpg-agent`.
   Reason: the daemon has no terminal, so pinentry-curses fails whenever the agent cache is cold.
   Trade-off: `pass` in a terminal inside Hyprland also gets the GTK window.
3. Harden with a drop-in, `systemctl --user edit pass-secret-service.service`:

   ```ini
   [Service]
   PrivateNetwork=yes
   ```

   Safe because the session bus (`unix:path=/run/user/1000/bus`)
   and the gpg-agent socket are path-based.
   Optional: `ExecStart=` override with `-n` to get a notification on every secret read.

4. Start Zotero.
   The notice should not appear.
   Check with `pass ls secret-service`.
5. Optional: unlink and re-link the account to drop the plaintext copy (needs the Zotero login).
6. Add `secret-service/collections.redb` to the store's `.gitignore`, or commit it.

## Alternative: gnome-keyring

Wiki: <https://wiki.archlinux.org/title/GNOME/Keyring>.
D-Bus activation ships with the package, no Hyprland config change needed.

1. `sudo pacman -S gnome-keyring`
2. `/etc/pam.d/login`, after the matching `include system-local-login` lines:

   ```
   auth       optional     pam_gnome_keyring.so
   session    optional     pam_gnome_keyring.so auto_start
   ```

3. Log out and in on tty1, start Zotero, sync once.

## Alternative: oo7

Wiki: <https://wiki.archlinux.org/title/Oo7>.
Same PAM idea with `pam_oo7.so` on the `auth` and `session` lines (no `auto_start`),
plus `systemctl --user enable oo7-daemon.service`.
Conflicts with gnome-keyring and with pass-secret-service.
