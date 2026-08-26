-- Options

-- filetype
vim.g.tex_flavor = "latex"

-- provider
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- `:help options`, compact list under `:help option-list`
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- `clipboard-osc52` or system clipboard
vim.opt.colorcolumn = { "80", "100" }
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.formatoptions = "tcqnj"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.mouse = "a" -- like a pleb
vim.opt.nrformats:append({ "blank" })
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.shortmess:append({ I = true })
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes:1"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spelllang = { "en", "de" }
vim.opt.spelloptions = { "camel" }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.virtualedit = { "block" }
vim.opt.wildmode = "longest:full,full"
vim.opt.winborder = "rounded"
vim.opt.wrap = false
