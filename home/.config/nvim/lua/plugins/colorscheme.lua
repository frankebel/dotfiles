-- Colorscheme dracula.
-- https://github.com/catppuccin/nvim

return {
  "catppuccin/nvim",
  -- version = "*", lastest one from 2024-08-10
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
