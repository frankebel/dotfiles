#!/bin/sh
# Information about new, unread mail.

# count new mail for each account
MAILDIR="$XDG_DATA_HOME/isync"
M1="$(find "$MAILDIR/mailbox/INBOX/new" -type f | wc -l)"
M2="$(find "$MAILDIR/tuw/INBOX/new" -type f | wc -l)"
text="$M1 $M2"

# check if widget should be active, otherwise empty string
Mtot=$((M1 + M2))
[ "$Mtot" -gt 0 ] && printf '%s\n' "$text" || printf ''
