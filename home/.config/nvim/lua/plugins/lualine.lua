-- Lualine
-- https://github.com/nvim-lualine/lualine.nvim

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
  },
}
