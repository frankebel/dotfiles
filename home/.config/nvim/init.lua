vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Plugin to improve viewing Markdown files in Neovim
-- (needs to be loaded early)
vim.pack.add({
  {
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    version = vim.version.range("*"),
  },
})

require("render-markdown").setup({
  sign = {
    enabled = false,
  },
})
