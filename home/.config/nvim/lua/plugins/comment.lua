-- Keymaps for commenting.
-- https://github.com/numToStr/Comment.nvim

return {
  "numToStr/Comment.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = true,
}
