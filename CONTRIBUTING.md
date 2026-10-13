# Contributing

## Config file headers

A config file whose filetype Neovim does not detect starts with

```
# vim: ft=<filetype>
# See <reference>
```

where `#` is the comment character of the filetype.

The first line is a modeline (`nvim -c 'help modeline'`).
A config file whose filetype Neovim detects,
opened from the repository,
leaves it out and may start with the second line alone.

The second line names, in order of preference:

- the man page of the config file, e.g. `dunst(5)`
- the man page of the program, e.g. `rg(1)`
- the help command of the program, e.g. `` `:help` ``
- a URL to the documentation

A copied file that needs a header
gets its source URL as a third line.
