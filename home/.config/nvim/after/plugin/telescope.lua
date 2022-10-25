-- Telescope
-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require "telescope"

telescope.setup {
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    sorting_strategy = "ascending",
  },
  pickers = {
    find_files = {
      -- Find hidden files but ignore `.git` directory
      find_command = { "rg", "--files", "--hidden", "--glob", "!./git/*" },
    },
  },
}

-- Load extensions
telescope.load_extension "fzf"