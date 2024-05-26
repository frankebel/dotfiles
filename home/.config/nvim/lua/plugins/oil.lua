-- File explorer that lets you edit your filesystem like a normal Neovim buffer.
-- https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "OIL Toggle file manager" },
  },
  opts = {
    view_options = { show_hidden = true },
  },
}
