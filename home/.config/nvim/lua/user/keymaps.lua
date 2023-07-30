local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<cr>", "Next buffer")
map("n", "<S-h>", "<cmd>bprevious<cr>", "Previous buffer")

-- Move to window with <ctrl> hjkl
map("n", "<C-h>", "<C-w>h", "Move left window")
map("n", "<C-j>", "<C-w>j", "Move lower window")
map("n", "<C-k>", "<C-w>k", "Move upper window")
map("n", "<C-l>", "<C-w>l", "Move right window")

-- Resize window with <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Open/close vsplit
map("n", "<leader>-", "<cmd>vsplit<cr>", "Open vsplit")
map("n", "<leader>_", "<c-w>q", "Close vsplit")

-- Reselect visual area
map("v", "<", "<gv", "Shift left")
map("v", ">", ">gv", "Shift right")

-- Search
map({ "i", "n" }, "<esc>", "<cmd>nohlsearch<cr><esc>", "Escape and clear hlsearch")
map({ "n", "x" }, "gw", "*N", "Search word under cursor")

-- Move text up and down
map("x", "K", ":move '<-2<CR>gv-gv", "Move lines up")
map("x", "J", ":move '>+1<CR>gv-gv", "Move lines down")

-- Paste without yanking
map("v", "p", '"_dP', "Paste without yanking")

-- Delete current buffer and move to next
map("n", "<leader>bd", "<cmd>bn<cr><cmd>bd#<cr>", "Delete current buffer")

-- Toggle options
map("n", "<leader>or", "<cmd>set invrelativenumber<cr>", "Toggle relativenumber")
map("n", "<leader>os", "<cmd>set invspell<cr>", "Toggle spell")
map("n", "<leader>ow", "<cmd>set invwrap<cr>", "Toggle wrap")
