-- Preview markdown on your modern browser with synchronised scrolling and
-- flexible configuration.
-- https://github.com/iamcco/markdown-preview.nvim

return {
  "iamcco/markdown-preview.nvim",
  version = "*",
  build = "cd app && yarn install",
  ft = "markdown",
  config = function()
    vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
  end,
}
