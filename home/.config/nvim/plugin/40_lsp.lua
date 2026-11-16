-- See `:help lsp`

vim.pack.add({
  {
    src = "https://github.com/barreiroleo/ltex_extra.nvim",
    version = "dev",
  },
})

-- https://github.com/barreiroleo/ltex_extra.nvim
require("ltex_extra").setup({
  load_langs = { "en-US" },
  path = ".ltex",
})

vim.lsp.enable({
  -- Bash
  "bashls",
  -- Julia
  "jetls",
  -- LaTeX
  "ltex_plus",
  "texlab",
  -- Lua
  "lua_ls",
  -- Python
  "basedpyright",
  "ruff",
})
