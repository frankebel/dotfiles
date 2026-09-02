-- Navigate buffers
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Move to window with <ctrl> hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right window" })

-- Resize window with <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Reselect visual area
vim.keymap.set("v", "<", "<gv", { desc = "Shift left" })
vim.keymap.set("v", ">", ">gv", { desc = "Shift right" })

-- Search
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Escape and clear hlsearch" })

-- Toggle options
vim.keymap.set("n", "<leader>ow", "<cmd>set invwrap<cr>", { desc = "Toggle wrap" })

-- Go line by line with `wrap` unless count (e.g. 4j) is given
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- LSP
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic set loclist" })

-- text
vim.keymap.set("n", "<leader>id", "<cmd>put =strftime('%F')<cr>kJA", { desc = "Insert date" })

-- clipboard
vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy filepath to clipboard" })

-- terminal
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
