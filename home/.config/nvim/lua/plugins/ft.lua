-- Plugins which are filetype specific.

return {
  {
    -- https://github.com/tridactyl/vim-tridactyl
    "tridactyl/vim-tridactyl",
    ft = "tridactyl",
  },
  {
    -- https://github.com/iamcco/markdown-preview.nvim
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    config = function()
      vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
    end,
  }
}
