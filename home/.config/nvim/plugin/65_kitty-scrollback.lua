-- Navigate your Kitty scrollback buffer to quickly search, copy, and execute commands in Neovim.

vim.pack.add({
  {
    src = "https://github.com/mikesmithgh/kitty-scrollback.nvim",
    version = vim.version.range("*"),
  },
})
