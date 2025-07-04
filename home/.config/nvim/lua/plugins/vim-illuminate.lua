-- Highlighting other uses of the word under the cursor using either
-- LSP, Tree-sitter, or regex matching.
-- https://github.com/RRethy/vim-illuminate

return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    large_file_cutoff = 2000,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
