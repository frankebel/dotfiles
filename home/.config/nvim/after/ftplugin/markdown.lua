-- Tabs and indents
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Keymaps
vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
