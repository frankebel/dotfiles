# Neovim Config

My main text editor which I use to edit text files. Images are shown in the main
[README](../../../README.md). If possible [Lua](https://www.lua.org/) was used
instead of Vimscript.

The configuration is modular as can be seen from the file tree:

```
 .
├──  after
│   └──  ftplugin
│       ├──  filetype.lua
│       ⋮
├──  lua
│   ├──  plugins
│   │   ├──  plugin1.lua
│   │   ├──  plugin2.lua
│   │   ⋮
│   └──  user
│       ├──  autocmds.lua
│       ├──  init.lua
│       ├──  keymaps.lua
│       ├──  lazy.lua
│       └──  options.lua
├──  spell
│   ├──  de
│   └──  en
├──  init.lua
└──  lazy-lock.json
```

## Main file

[`init.lua`](./init.lua) is held very simple.

## Basic configuration

The basic configuration is done within the [`user`](./lua/user/) directory.

## Plugins

I use [lazy.nvim](https://github.com/folke/lazy.nvim) as my plugin manager.
Plugins themselves are configured in the [`plugin`](./lua/plugins/) directory
with mostly one file per plugin. [`lazy-lock.json`](./lazy-lock.json) lists all
plugins I currently use.

## File specific configuration

If I want file type specific options or plugins I set them under
[`after/ftplugin`](./after/ftplugin/).

## Spell check

Spellcheck is configured for German and English.
