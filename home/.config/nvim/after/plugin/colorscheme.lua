-- Colorscheme
-- https://github.com/Mofiqul/dracula.nvim
local colorscheme = "dracula"

local status, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status then
  vim.notify("colorscheme " .. colorscheme .. " not found")
  return
end
