return {
  -- git decorations
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

      -- stylua: ignore start
      map("n", "]g", gs.next_hunk, "gitsigns next hunk")
      map("n", "[g", gs.prev_hunk, "gitsigns prev hunk")
      map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "gitsigns reset hunk")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "gitsigns blame line")
      map("n", "<leader>ghd", gs.diffthis, "gitsigns diff this")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "gitsigns diff this ~")
        -- stylua: ignore end
      end,
    },
  },

  -- keymaps for commenting
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- highlight uses of word under cursor
  -- https://github.com/RRethy/vim-illuminate
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({})
    end,
  },

  -- File Explorer
  -- https://github.com/stevearc/oil.nvim
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    cmd = "Oil",
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Toggle file manager" },
    },
    opts = {
      view_options = { show_hidden = true },
    },
  },

  -- highlight and search todo comments
  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    version = "*",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },
}
