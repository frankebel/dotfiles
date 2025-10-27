-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/barreiroleo/ltex_extra.nvim

-- Julia
vim.lsp.enable("julials")

-- LaTeX
require("ltex_extra").setup({
  load_langs = { "en-US" },
  path = ".ltex",
})
vim.lsp.config("ltex_plus", {
  settings = {
    ltex = {
      language = "en-US",
      additionalRules = {
        enablePickyRules = true,
      },
    },
  },
})
vim.lsp.enable({
  "ltex_plus",
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
