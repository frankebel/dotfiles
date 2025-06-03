-- A collection of small QoL plugins for Neovim.
-- https://github.com/folke/snacks.nvim

return {
  "folke/snacks.nvim",
  version = "*",
  lazy = false,
  priority = 1000,
  opts = {
    image = {
      doc = {
        enabled = true,
        max_width = 100,
        max_height = 100,
      },
      math = {
        latex = {
          font_size = "large",
        },
      },
    },
  },
}
