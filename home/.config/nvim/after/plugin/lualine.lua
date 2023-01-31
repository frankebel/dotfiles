-- Statusline
-- https://github.com/nvim-lualine/lualine.nvim

local status, lualine = pcall(require, "lualine")
if not status then
  return
end

lualine.setup {
  options = {
    component_separators = "|",
    section_separators = "",
  },
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_x = { "filetype" },
  },
  inactive_sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
  },
}
