-- File manager
-- https://github.com/nvim-tree/nvim-tree.lua

require "nvim-tree".setup {
  view = {
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
}
