-- Language Server Protocol LSP
-- https://microsoft.github.io/language-server-protocol/
-- `:help lsp`

vim.pack.add({
  {
    src = "https://github.com/barreiroleo/ltex_extra.nvim",
    version = "dev",
  },
})

vim.lsp.enable({
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
