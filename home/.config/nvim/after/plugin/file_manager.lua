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
