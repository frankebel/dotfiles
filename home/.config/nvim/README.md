# Neovim Config

My main text editor which I use to edit text files. Images are shown in the main
[README](../../../README.md). If possible [Lua](https://www.lua.org/) was used
instead of Vimscript.

The configuration is modular as can be seen from the file tree:

```
.
├── after
│   └── ftplugin
│       ├── filetype1.lua
│       ├── filetype2.lua
│       ⋮
├── lua
│   └── plugins
│       ├── plugin1.lua
│       ├── plugin2.lua
│       ⋮
├── plugin
│   ├── file1.lua
│   ├── file2.lua
│   ⋮
├── spell
│   └── en.utf-8.add
├── init.lua
└── lazy-lock.json
```

## Main file

[`init.lua`](init.lua) sets up the plugin manager
[lazy.nvim](https://github.com/folke/lazy.nvim).

## Basic configuration

The basic configuration is done within the [`plugin`](plugin) directory.
As this is in the runtimepath (`:help runtimepath`),
files will be sourced automatically.

## Plugins

I use [lazy.nvim](https://github.com/folke/lazy.nvim) as my plugin manager.
Plugins themselves are configured in the [`lua/plugins`](lua/plugins/)
directory with mostly one file per plugin.
[`lazy-lock.json`](lazy-lock.json) lists all plugins I currently use.

## File specific configuration

If I want file type specific options or plugins I set them under
[`after/ftplugin`](after/ftplugin/).

## Spell check

Spellcheck is configured for German and English. To add my custom word list to
the spell checker run:

```sh
cd ~/.config/nvim/spell
nvim en.utf-8.add
:mkspell! %.spl %
```

More information under `:help spell`.
