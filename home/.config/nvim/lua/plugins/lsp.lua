-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/barreiroleo/ltex_extra.nvim

return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local servers = {
        -- Julia
        julials = true,
        -- LaTeX
        ltex = {
          settings = {
            ltex = {
              language = "en-US",
            },
          },
        },
        texlab = true,
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              format = { enable = false },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        -- Python
        pyright = true,
      }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
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
          local builtin = require("telescope.builtin")
          local function nmap(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = 0 })
          end
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          nmap("gd", builtin.lsp_definitions, "LSP Go to definition")
          nmap("gr", builtin.lsp_references, "LSP List references")
          nmap("gD", vim.lsp.buf.declaration, "LSP Go to declaration")
          nmap("gT", vim.lsp.buf.type_definition, "LSP Type definition")
          nmap("K", vim.lsp.buf.hover, "LSP Hover documentation")

          nmap("<leader>rn", vim.lsp.buf.rename, "LSP Rename")
          nmap("<leader>ca", vim.lsp.buf.code_action, "LSP Code action")

          nmap("gi", vim.lsp.buf.implementation, "LSP Go to implementation")
          nmap("<C-k>", vim.lsp.buf.signature_help, "LSP Signature documentation")

          nmap("<leader>ld", vim.diagnostic.open_float, "LSP Diagnostic open float")
          nmap("[d", vim.diagnostic.goto_prev, "LSP Prev Diagnostic")
          nmap("]d", vim.diagnostic.goto_next, "LSP Next Diagnostic")
          nmap("<leader>q", vim.diagnostic.setloclist, "LSP Diagnostic set loclist")

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
  {
    "barreiroleo/ltex_extra.nvim",
    branch = "dev",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      load_langs = { "en-US" },
    },
  },
}
