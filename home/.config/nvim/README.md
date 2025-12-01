# Neovim Config

My main text editor which I use to edit text files.
If possible [Lua](https://www.lua.org/) was used instead of Vimscript.

The configuration is modular as can be seen from the file tree.
Most settings are written in files inside the [`plugin`](plugin) directory
with numbers determining loading order.
They will be sourced automatically (`:help runtimepath`).

```
.
├── after
│   └── ftplugin
│       ├── filetype1.lua
│       ├── filetype2.lua
│       ⋮
├── lsp
│   ├── language1.lua
│   ├── language2.lua
│   ⋮
├── plugin
│   ├── 1_file.lua
│   ├── 2_file.lua
│   ⋮
├── spell
│   └── en.utf-8.add
├── init.lua
└── nvim-pack-lock.json
```

## Plugins

I use `vim.pack` as my plugin manager.
[`nvim-pack-lock.json`](nvim-pack-lock.json) lists all plugins I currently use.

## File specific configuration

If I want to set something only for a specific file type,
I set them under [`after/ftplugin`](after/ftplugin/).

## Spell check

Spellcheck is configured for German and English. To add my custom word list to
the spell checker run:

```sh
cd ~/.config/nvim/spell
nvim en.utf-8.add
:mkspell! %.spl %
```

More information under `:help spell`.
