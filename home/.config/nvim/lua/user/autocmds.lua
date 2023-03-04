-- Create automatic commands
-- See :h autocmd

local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("my_group", { clear = true })

-- Remove trailing whitespace
autocmd(
  {"BufWritePre"},
  {
    group = group,
    pattern = "*",
    command = "%s/\\v\\s+$//e",
  }
)

