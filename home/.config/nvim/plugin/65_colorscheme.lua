vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    version = vim.version.range("*"),
    name = "catppuccin",
  },
})

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true, -- use kitty background
})

vim.cmd.colorscheme("catppuccin-nvim")
