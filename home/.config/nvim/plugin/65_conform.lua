-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "black" },
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
