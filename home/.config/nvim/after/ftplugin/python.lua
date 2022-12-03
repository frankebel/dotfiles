-- Line wrap
vim.opt.textwidth = 79

-- Tabs and indents
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Uncategorized
vim.opt.colorcolumn = "80"

-- Keymaps
vim.keymap.set("n", "<leader>x", "<cmd>!python %<cr>", { desc = "Run current file" })
