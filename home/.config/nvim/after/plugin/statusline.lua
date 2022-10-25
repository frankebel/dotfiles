-- Statusline
-- https://github.com/nvim-lualine/lualine.nvim

require "lualine".setup {
  options = {
    component_separators = "|",
    section_separators = "",
  },
  sections = {
    lualine_x = { "filetype" },
  },
}
