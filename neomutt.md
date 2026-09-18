Wire up Notmuch full-text search
(docs: <https://docs.neomutt.org/tutorials/notmuch-setup.html>)

Prereqs are met: `notmuch` and neomutt's `+notmuch` are both installed.

1. `notmuch setup` with database path `~/.local/share/isync`
   (both Maildir trees under one root; one index covers both accounts),
   `[new] ignore = .mbsyncstate;.uidvalidity`.
2. Run `notmuch new` once to build the initial index.
3. In `neomutt/neomuttrc`:
   `set nm_default_url = "notmuch:///home/frank/.local/share/isync"`.
   Optionally add virtual mailboxes
   (e.g. `named-mailboxes "Unread" "notmuch://?query=tag:unread"`).
4. In `systemd/user/mailsync.service`, extend the sync to also index:
   `ExecStart=/usr/bin/mbsync --all && /usr/bin/notmuch new`.

Note: a single index spans both accounts — queries return mail
from `mailbox` and `tuw` together.
