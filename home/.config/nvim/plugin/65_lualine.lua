-- A blazing fast and easy to configure Neovim statusline written in Lua.
-- https://github.com/nvim-lualine/lualine.nvim

require("lualine").setup({
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
})
