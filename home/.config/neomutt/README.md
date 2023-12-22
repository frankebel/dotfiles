# OAuth 2.0 Setup

[Microsoft 365](https://www.office.com/) uses
[OAuth 2.0](https://en.wikipedia.org/wiki/OAuth) for IMAP and SMTP
authentication which does not work natively in isync and neomutt.

## NeoMutt

Follow the official
[guide](https://neomutt.org/guide/optionalfeatures#6-%C2%A0oauthbearer-and-xoauth2-support).
It suggest to download
[mutt_oauth2.py](https://github.com/neomutt/neomutt/tree/main/contrib/oauth2)
from GitHub.

### mutt_oauth2.py

Information can be accessed in the accompanying README. The following is a
summary.

Run the following command and follow its instructions:

```sh
chmod +x mutt_oauth2.py
./mutt_oauth2.py token \
    --authorize \
    --provider microsoft \
    --client-id "08162f7c-0fd2-4200-a84a-f25a4db0b584" \
    --client-secret "TxRBilcHdC6WGBee]fs?QR:SJ8nI[g82" \
    --authflow localhostauthcode
```

The `client-id` and `client-secret` are taken from Thunderbird which can be
obtained from an old version of this
[file](https://hg.mozilla.org/comm-central/file/tip/mailnews/base/src/OAuth2Providers.jsm).

If everything worked, the following should run without any problem:

```sh
./mutt_oauth2.py token --verbose --test
gpg --decrypt token | jq
```

## isync

Follow the guide on the
[ArchWiki](https://wiki.archlinux.org/title/Isync#Using_XOAUTH2) by installing
[cyrus-sasl-xoauth2-git](https://aur.archlinux.org/packages/cyrus-sasl-xoauth2-git).
