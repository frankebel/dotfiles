-- File manager
-- https://github.com/nvim-tree/nvim-tree.lua

local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  return
end

nvim_tree.setup {
  view = {
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
}


-- Keymaps
local keymap = vim.keymap.set
local api = require("nvim-tree.api")

keymap("n", "<leader>e", api.tree.toggle, { desc = "Toggle file manager" })
