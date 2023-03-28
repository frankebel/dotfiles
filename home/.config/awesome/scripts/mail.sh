#!/bin/sh
# Text for mail widget.

MAILDIR="$HOME/.local/share/isync"
mbox="mailbox"
tuw="tuw"

mbox_new=$(find "$MAILDIR/$mbox/INBOX/new/" -type f | wc -l)
tuw_new=$(find "$MAILDIR/$tuw/INBOX/new/" -type f | wc -l)

printf " %i %i" "$mbox_new" "$tuw_new"
