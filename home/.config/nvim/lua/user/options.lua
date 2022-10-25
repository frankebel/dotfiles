-- Options
-- :help options
-- https://neovim.io/doc/user/options.html

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Formatoptions
vim.opt.formatoptions:remove("a")
vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("n")
vim.opt.formatoptions:append("c")

-- Line number
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

-- Line wrap
vim.opt.linebreak = true
vim.opt.showbreak = "   "
vim.opt.wrap = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Split
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true

-- Tabs and indents
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Uncategorized
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.undofile = true
