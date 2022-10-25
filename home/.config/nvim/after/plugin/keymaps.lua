local keymap = vim.keymap.set

-- Buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", { silent = true })
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { silent = true })

-- Splits
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Indent mode stay
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
keymap("x", "K", ":move '<-2<CR>gv-gv", { silent = true })

-- Paste without yanking
keymap("v", "p", '"_dP', { silent = true })

-- Plugins
-- Telescope
local builtin = require "telescope.builtin"
local function search_dotfiles()
  builtin.find_files {
    prompt_title = "Find Dotfiles",
    cwd = "~/.dotfiles",
  }
end

keymap("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
keymap("n", "<leader>fb", builtin.buffers, { desc = "List Buffers" })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
keymap("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
keymap("n", "<leader>fo", builtin.oldfiles, { desc = "Find previously open files" })

keymap("n", "<leader>fdf", search_dotfiles, { desc = "Find dotfiles" })

-- Gitsigns
local gitsigns = require "gitsigns"
keymap("n", "<leader>hn", gitsigns.next_hunk)
keymap("n", "<leader>hp", gitsigns.prev_hunk)
keymap("n", "<leader>hh", gitsigns.preview_hunk, { desc = "preview_hunk" })
keymap("n", "<leader>hb", gitsigns.blame_line, { desc = "blame_line" })

-- Nvim-tree
local nvim_tree = require "nvim-tree.api"
keymap("n", "<leader>e", nvim_tree.tree.toggle, { desc = "Toggle file manager" })