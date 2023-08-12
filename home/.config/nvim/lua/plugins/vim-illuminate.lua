-- Highlighting other uses of the word under the cursor using either
-- LSP, Tree-sitter, or regex matching.
-- https://github.com/RRethy/vim-illuminate

return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({})
  end,
}
