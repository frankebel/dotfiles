-- File explorer that lets you edit your filesystem like a normal Neovim buffer.
-- https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  cmd = "Oil",
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Toggle file manager" },
  },
  opts = {
    view_options = { show_hidden = true },
  },
}
