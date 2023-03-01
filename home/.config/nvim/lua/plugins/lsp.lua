-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Keymaps
    local keymap = vim.keymap.set

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    keymap("n", "<leader>ld", vim.diagnostic.open_float)
    keymap("n", "[d", vim.diagnostic.goto_prev)
    keymap("n", "]d", vim.diagnostic.goto_next)
    keymap("n", "<leader>q", vim.diagnostic.setloclist)

    local lspconfig = require("lspconfig")
    local lsp_conf = require("user.lsp")

    -- Lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = {
            globals = {
              "awesome",
              "client",
              "root",
              "vim",
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
      capabilities = lsp_conf.capabilities,
      flags = lsp_conf.lsp_flags,
      on_attach = lsp_conf.on_attach,
    }

    -- Python
    lspconfig.pyright.setup {
      capabilities = lsp_conf.capabilities,
      flags = lsp_conf.lsp_flags,
      on_attach = lsp_conf.on_attach,
    }
  end,
}
