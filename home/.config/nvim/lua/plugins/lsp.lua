-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/barreiroleo/ltex_extra.nvim

return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      {
        "barreiroleo/ltex_extra.nvim",
        version = "*",
        branch = "dev",
      },
    },
    config = function()
      -- Julia
      vim.lsp.enable("julials")

      -- LaTeX
      vim.lsp.config("ltex", {
        settings = {
          ltex = {
            language = "en-US",
            additionalRules = {
              enablePickyRules = true,
            },
          },
        },
        on_attach = function()
          require("ltex_extra").setup({
            load_langs = { "en-US" },
            path = ".ltex",
          })
        end,
      })
      vim.lsp.enable({
        "ltex",
        "texlab",
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = {
                "Snacks",
                "vim",
              },
            },
            format = { enable = false },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- Python
      vim.lsp.enable("pyright")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          -- Keymaps
          -- See `:help vim.diagnostic.*` for documentation on any of the below functions
          local function nmap(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = 0 })
          end
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          nmap("gT", vim.lsp.buf.type_definition, "LSP Type definition")
        end,
      })
    end,
  },
}
