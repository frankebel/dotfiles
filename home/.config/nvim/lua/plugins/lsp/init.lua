-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/mfussenegger/nvim-jdtls

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
    },
    config = function()
      -- Keymaps
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local function nmap(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end
      nmap("<leader>ld", vim.diagnostic.open_float, "Diagnostic open float")
      nmap("[d", vim.diagnostic.goto_prev, "Next Diagnostic")
      nmap("]d", vim.diagnostic.goto_next, "Prev Diagnostic")
      nmap("<leader>q", vim.diagnostic.setloclist, "Diagnostic set loclist")

      local lspconfig = require("lspconfig")
      local lsp_conf = require("plugins.lsp.config")

      -- Lua
      lspconfig.lua_ls.setup({
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
            format = { enable = false },
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
      })

      -- Python
      lspconfig.pyright.setup({
        capabilities = lsp_conf.capabilities,
        flags = lsp_conf.lsp_flags,
        on_attach = lsp_conf.on_attach,
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
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
          -- lua
          null_ls.builtins.formatting.stylua,
          -- python
          null_ls.builtins.diagnostics.flake8.with({
            extra_args = {
              "--max-line-length",
              "88",
              "--extend-ignore",
              "E203",
            },
          }),
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.formatting.black,
          -- sh
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.shfmt.with({
            extra_args = {
              "--indent",
              "4",
              "--binary-next-line",
              "--case-indent",
              "--space-redirects",
            },
          }),
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
}
