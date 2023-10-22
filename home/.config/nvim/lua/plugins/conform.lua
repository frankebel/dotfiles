-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim

return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  cmd = "ConformInfo",
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "conform Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "prettierd" },
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
      lsp_fallback = true,
    },
  },
}
