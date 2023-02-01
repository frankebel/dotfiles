local keymap = vim.keymap.set

-- Buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", { silent = true })
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { silent = true })

-- Splits
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })
keymap("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "vsplit"})

-- Indent mode stay
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
keymap("x", "K", ":move '<-2<CR>gv-gv", { silent = true })

-- Delete without yanking
keymap("n", "<leader>dd", '"_dd', { desc = "Delete without yanking" })
keymap("v", "<leader>d", '"_d', { desc = "Delete without yanking" })
-- Paste without yanking
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Close current buffer
keymap("n", "<leader>bd", "<cmd>bn<cr><cmd>bd#<cr>", { desc = "Delete current buffer"})

-- Toggle options
-- Start with "<leader>o"
keymap("n", "<leader>or", "<cmd>set invrelativenumber<CR>", { desc = "Toggle relativenumber" })
keymap("n", "<leader>ow", "<cmd>set invwrap<CR>", { desc = "Toggle wrap" })
