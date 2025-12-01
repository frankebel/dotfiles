-- Lightweight yet powerful formatter plugin for Neovim

vim.pack.add({
  {
    src = "https://github.com/stevearc/conform.nvim",
    version = vim.version.range("*"),
  },
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "prettier" },
    sh = { "shfmt" },
  },
  formatters = {
    shfmt = {
      prepend_args = {
        "--indent",
        "4",
        "--binary-next-line",
        "--case-indent",
        "--space-redirects",
      },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "conform Format buffer" })
