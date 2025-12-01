-- File explorer that lets you edit your filesystem like a normal Neovim buffer.

vim.pack.add({
  {
    src = "https://github.com/stevearc/oil.nvim",
    version = vim.version.range("*"),
  },
})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "OIL Toggle file manager" })
