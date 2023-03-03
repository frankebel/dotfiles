-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/mfussenegger/nvim-jdtls

return {
  {
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
      local lsp_conf = require("plugins.lsp.config")

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
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup {
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFromatting", { clear = true })
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
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
}
