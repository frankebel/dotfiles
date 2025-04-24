-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/barreiroleo/ltex_extra.nvim

return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      {
        "barreiroleo/ltex_extra.nvim",
        version = "*",
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      local servers = {
        -- Julia
        julials = {},
        -- LaTeX
        ltex = {
          settings = {
            ltex = {
              language = "en-US",
            },
          },
        },
        texlab = {},
        -- Lua
        lua_ls = {
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
        },
        -- Python
        pyright = {},
      }

      for name, config in pairs(servers) do
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          -- Keymaps
          -- See `:help vim.diagnostic.*` for documentation on any of the below functions
          local function nmap(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = 0 })
          end
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          nmap("gD", vim.lsp.buf.declaration, "LSP Go to declaration")
          nmap("gT", vim.lsp.buf.type_definition, "LSP Type definition")

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })
    end,
  },
}
