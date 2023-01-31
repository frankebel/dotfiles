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


-- Keymaps
local keymap = vim.keymap.set

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap("n", "<leader>ld", vim.diagnostic.open_float)
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "<leader>q", vim.diagnostic.setloclist)
