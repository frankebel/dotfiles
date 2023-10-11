-- Add indentation guides to all lines.
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = true,
}
