vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    version = vim.version.range("*"),
    name = "catppuccin",
  },
})

require("catppuccin").setup({
  flavour = "mocha",
})

vim.cmd("colorscheme catppuccin")
