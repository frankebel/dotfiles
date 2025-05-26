-- Colorscheme dracula.
-- https://github.com/catppuccin/nvim

return {
  "catppuccin/nvim",
  version = "*",
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
