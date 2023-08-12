-- Add indentation guides to all lines.
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    show_current_context = true,
    show_current_context_start = true,
  },
}
