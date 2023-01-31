-- Gitsigns
-- https://github.com/lewis6991/gitsigns.nvim

local status, gitsigns = pcall(require, "gitsigns")
if not status then
  return
end

gitsigns.setup()


-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>hn", gitsigns.next_hunk)
keymap("n", "<leader>hp", gitsigns.prev_hunk)
keymap("n", "<leader>hh", gitsigns.preview_hunk, { desc = "preview_hunk" })
keymap("n", "<leader>hb", gitsigns.blame_line, { desc = "blame_line" })
