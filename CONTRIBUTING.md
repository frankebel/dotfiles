# Contributing

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org),
with the program as scope, e.g. `feat(neovim): create config`,
and no scope for changes across programs.

## Config file headers

A config file under `home/` starts with a header,
where `#` stands for the comment syntax of the filetype:

```
# vim: ft=<filetype>
# See <reference>
# Copied from <source URL>
# <change that saving in Neovim does not make>
```

Each line appears only where it applies:

- The modeline (`nvim -c 'help modeline'`),
  when Neovim, opened from the repository,
  does not detect the filetype or detects it wrongly.
- The reference must exist in a main config file
  (primary entry file of a program, such as `nvim/init.lua`)
  and is optional in any other config file.
  The reference names the first of these that exists:
  - the man page of the config file, e.g. `dunst(5)`
  - the man page of the program, e.g. `rg(1)`
  - the help command of the program, e.g. `` `:help` ``
  - a URL to the documentation
- The source URL, in a file copied from upstream,
  and below it a line for each change that saving in Neovim does not make,
  e.g. ``# tabs expanded with `expand -t 2` ``,
  see [Upstream content](#upstream-content).

A file that the program writes itself, such as `btop.conf`, has no header,
and neither has a file in a format without comments, such as JSON.
A format whose first line is fixed, such as XML,
starts the header on the second line.

## Other config files

- Formats that quote like shell, such as neomutt and bat's config,
  follow the [shell code](#shell-code) rules.
- Other formats quote a value only when the format requires it.
- Write `=` the same way throughout a file,
  as the format's documentation does.

## Shell code

- Quote assignment values, except plain integers.
- Use double quotes when the string contains an expansion (`$`),
  and single quotes otherwise,
  unless the string contains a single quote.
- Write variables as `$var`,
  with braces only where needed (`${var}_suffix`, `${var:-default}`).
- Write long options with a value as `--option=value`.
- In a shell script, print with `printf`, not `echo`.

## Upstream content

A file copied from upstream follows the same rules as any other file.

- Sync it by copying the upstream file below the header,
  applying the change in the header,
  and saving it in Neovim.
- Override its settings in the config file that includes it,
  after the include, as in `kitty.conf`.
