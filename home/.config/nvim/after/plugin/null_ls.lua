-- null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local group = vim.api.nvim_create_augroup("LspFromatting", { clear = true })

null_ls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
      vim.api.nvim_create_autocmd(
        "BufWritePre",
        {
          group = group,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        }
      )
    end
  end,
  sources = {
    -- lua
    -- require"null-ls".builtins.diagnostics.selene,
    -- require"null-ls".builtins.formatting.stylua,

    -- python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.autopep8,

    -- sh
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
  },
}
