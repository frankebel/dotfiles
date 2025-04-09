-- Navigate your Kitty scrollback buffer to quickly search, copy, and execute commands in Neovim.
-- https://github.com/mikesmithgh/kitty-scrollback.nvim

return {
  "mikesmithgh/kitty-scrollback.nvim",
  version = "*",
  lazy = true,
  cmd = {
    "KittyScrollbackCheckHealth",
    "KittyScrollbackGenerateCommandLineEditing",
    "KittyScrollbackGenerateKittens",
  },
  event = { "User KittyScrollbackLaunch" },
  opts = true,
}
