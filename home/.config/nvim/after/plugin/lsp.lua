-- LSP setup
-- https://github.com/neovim/nvim-lspconfig

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
  return
end


local status_luc, lsp_user_conf = pcall(require, "user.lsp")
if not status_luc then
  return
end

-- Lua
lspconfig["sumneko_lua"].setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "awesome",
          "vim",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
  capabilities = lsp_user_conf.capabilities,
  flags = lsp_user_conf.lsp_flags,
  on_attach = lsp_user_conf.on_attach,
}

-- Python
lspconfig["pyright"].setup {
  capabilities = lsp_user_conf.capabilities,
  flags = lsp_user_conf.lsp_flags,
  on_attach = lsp_user_conf.on_attach,
}
