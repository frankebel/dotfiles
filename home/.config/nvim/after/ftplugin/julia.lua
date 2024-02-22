-- Formatoptions
vim.opt.colorcolumn = { "92" }
vim.opt.formatoptions:remove({ "r", "o" })

-- Install LSP automatically.
local file = vim.fn.expand("~/.julia/environments/nvim-lspconfig/Manifest.toml")
if vim.fn.filereadable(file) == 0 and vim.fn.executable("julia") == 1 then
  os.execute(
    "julia" .. " --project=~/.julia/environments/nvim-lspconfig" .. " -e 'using Pkg; Pkg.add(\"LanguageServer\")'"
  )
end
