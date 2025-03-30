-- Plugin to improve viewing Markdown files in Neovim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "*",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = {
    "markdown",
  },
  keys = {
    {
      "<leader>m",
      function()
        require("render-markdown").toggle()
      end,
      desc = "Toggle render-markdown",
    },
  },
  opts = {},
}
