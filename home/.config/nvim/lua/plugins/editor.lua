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
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")
      map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
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
}
