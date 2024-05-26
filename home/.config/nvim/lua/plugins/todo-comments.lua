-- Highlight and search todo comments.
-- https://github.com/folke/todo-comments.nvim
return {
  "folke/todo-comments.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "TODO Next" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "TODO Prev" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO list" },
    },
}
