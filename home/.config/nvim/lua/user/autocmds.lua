-- Create automatic commands
-- See `:help autocmd`

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("delete_trailing_whitespace"),
  pattern = "*",
  command = "%s/\\v\\s+$//e",
})
