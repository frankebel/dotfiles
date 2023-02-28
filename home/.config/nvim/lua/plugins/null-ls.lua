-- null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local augroup = vim.api.nvim_create_augroup("LspFromatting", { clear = true })

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup {
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
      sources = {
        -- python
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.black,
        -- sh
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shfmt.with {
          extra_args = {
            "--indent",
            "4",
            "--binary-next-line",
            "--case-indent",
            "--space-redirects",
          },
        },
      },
    }
  end,
}
