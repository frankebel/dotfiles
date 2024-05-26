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
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "TELESCOPE Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "TELESCOPE Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "TELESCOPE List Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "TELESCOPE Find Help" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "TELESCOPE Find Keymaps" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "TELESCOPE Find Old Files" },
      {
        "<leader>faf",
        function()
          require("telescope.builtin").find_files({
            find_command = { "fd", "--follow", "--hidden", "--no-ignore" },
          })
        end,
        desc = "TELESCOPE Find all Files",
      },
      {
        "<leader>fdf",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Find Dotfiles",
            cwd = "~/.dotfiles/",
          })
        end,
        desc = "TELESCOPE Find Dotfiles",
      },
    },
    opts = {
      defaults = {
        layout_config = {
          prompt_position = "top",
          width = 0.9,
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--follow", "--hidden" },
        },
      },
    },
  },
}
