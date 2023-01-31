-- null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

null_ls.setup {
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
