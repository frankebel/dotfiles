-- Keymaps for commenting.
-- https://github.com/numToStr/Comment.nvim
-- Built-in commenting <https://neovim.io/doc/user/various.html#commenting>
-- uses wrong symbol for Markdown due to treesitter.

return {
  "numToStr/Comment.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = true,
}
