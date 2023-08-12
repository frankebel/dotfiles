-- Telescope is a highly extendable fuzzy finder over lists.
-- https://github.com/nvim-telescope/telescope.nvim

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find Old Files" },
      {
        "<leader>fdf",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Find Dotfiles",
            cwd = "~/.dotfiles",
          })
        end,
        desc = "Find Dotfiles",
      },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        prompt_prefix = "> ",
        selection_caret = "> ",
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--follow", "--hidden" },
        },
      },
    },
  },
}
