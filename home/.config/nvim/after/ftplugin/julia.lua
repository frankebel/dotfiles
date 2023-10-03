-- Formatoptions
vim.opt.formatoptions:remove({ "r", "o" })

-- Install LSP automatically.
local dir = vim.fn.expand("~/.julia/environments/nvim-lspconfig/")
if vim.fn.isdirectory(dir) == 0 and vim.fn.executable("julia") == 1 then
  os.execute(
    "julia" .. " --project=~/.julia/environments/nvim-lspconfig" .. " -e 'using Pkg; Pkg.add(\"LanguageServer\")'"
  )
end
