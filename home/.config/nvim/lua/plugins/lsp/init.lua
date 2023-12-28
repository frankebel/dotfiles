-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/barreiroleo/ltex_extra.nvim

-- Read spell file for LTeX
local function words()
  local result = {}
  local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
  for word in io.open(path, "r"):lines() do
    table.insert(result, word)
  end
  return result
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "barreiroleo/ltex_extra.nvim",
    },
    config = function()
      -- Keymaps
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local function nmap(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end
      nmap("<leader>ld", vim.diagnostic.open_float, "LSP Diagnostic open float")
      nmap("[d", vim.diagnostic.goto_prev, "LSP Prev Diagnostic")
      nmap("]d", vim.diagnostic.goto_next, "LSP Next Diagnostic")
      nmap("<leader>q", vim.diagnostic.setloclist, "LSP Diagnostic set loclist")

      local lspconfig = require("lspconfig")
      local lsp_conf = require("plugins.lsp.config")

      -- Julia
      lspconfig.julials.setup({
        capabilities = lsp_conf.capabilities,
        flags = lsp_conf.lsp_flags,
        on_attach = lsp_conf.on_attach,
      })

      -- LaTeX, LTeX
      lspconfig.ltex.setup({
        settings = {
          ltex = {
            language = "en-US",
            dictionary = {
              -- Want it like next line but does not work.
              -- ["en-US"] = { ":~/.config/nvim/spell/en.utf-8.add" },
              ["en-US"] = words() or {},
            },
          },
        },
        capabilities = lsp_conf.capabilities,
        flags = lsp_conf.lsp_flags,
        on_attach = lsp_conf.on_attach,
      })
      lspconfig.texlab.setup({
        capabilities = lsp_conf.capabilities,
        flags = lsp_conf.lsp_flags,
        on_attach = lsp_conf.on_attach,
      })

      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = {
                -- neovim
                "vim",
              },
            },
            format = { enable = false },
            workspace = {
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

      -- Add border.
      local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
      }
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
}
