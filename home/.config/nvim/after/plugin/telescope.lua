-- Telescope
-- https://github.com/nvim-telescope/telescope.nvim

local status, telescope = pcall(require, "telescope")
if not status then
  return
end

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
      find_command = { "fd", "--type", "f", "--follow", "--hidden" },
    },
  },
}

-- Load extensions
telescope.load_extension "fzf"


-- Keymaps
local keymap = vim.keymap.set
local builtin = require "telescope.builtin"

local function search_dotfiles()
  builtin.find_files {
    prompt_title = "Find Dotfiles",
    cwd = "~/.dotfiles",
  }
end

keymap("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
keymap("n", "<leader>fb", builtin.buffers, { desc = "List Buffers" })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
keymap("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
keymap("n", "<leader>fo", builtin.oldfiles, { desc = "Find previously open files" })

keymap("n", "<leader>fdf", search_dotfiles, { desc = "Find dotfiles" })
