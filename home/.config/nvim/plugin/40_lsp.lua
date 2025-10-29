-- Language Server Protocol LSP
-- https://microsoft.github.io/language-server-protocol/
-- `:help lsp`

-- Julia
vim.lsp.enable("julials")

-- LaTeX
vim.lsp.enable({
  "ltex_plus",
  "texlab",
})

-- Lua
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
