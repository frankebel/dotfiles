-- Options

-- filetype
vim.g.tex_flavor = "latex"

-- provider
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- `:help options`
-- Compact list under `:help option-list`
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Use `clipboard-osc52` or system clipboard
vim.opt.colorcolumn = { "80", "100" }
vim.opt.completeopt = { "menuone", "noselect" } -- Insert mode comlete options
vim.opt.cursorline = true -- Highlight text line of cursor line
vim.opt.expandtab = true -- Expand tabs into spaces
vim.opt.formatoptions = "tcqnj" -- Default "tcqj"
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.inccommand = "split" -- preview substitutions
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true -- Show relative line number
vim.opt.scrolloff = 8 -- Minimal number of lines to keep around cursor
vim.opt.shiftwidth = 4 -- Number of spaces for indent
vim.opt.shortmess:append({ I = true }) -- Don't give intro message when starting Vim
vim.opt.showmode = false -- Don't show mode
vim.opt.sidescrolloff = 8 -- Minimal number of columns to keep around cursor
vim.opt.signcolumn = "yes" -- Always show signcolumn
vim.opt.smartcase = true -- Overwrite 'ignorecase' with upper case characters
vim.opt.smartindent = true -- Smart autoindent when starting a new line
vim.opt.softtabstop = 4 -- Number of spaces <Tab> counts for while performing editing operations
vim.opt.spelllang = { "en", "de" } -- Spellcheck for these languages
vim.opt.spelloptions = { "camel" } -- camel case treated as separate word
vim.opt.splitbelow = true -- Splitting window below current one
vim.opt.splitright = true -- Splitting window right of current one
vim.opt.tabstop = 4 -- Number of spaces <Tab> counts for
vim.opt.termguicolors = true -- Enable 24-bit RGB color
vim.opt.undofile = true -- Save undo history
vim.opt.virtualedit = { "block" } -- Cursor can by anywhere in visual block mode
vim.opt.wildmode = "longest:full,full" -- Completion mode
vim.opt.winborder = "rounded" -- Style of floating windows
vim.opt.wrap = false -- Line wrap
