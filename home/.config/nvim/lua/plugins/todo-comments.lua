-- Highlight and search todo comments.
-- https://github.com/folke/todo-comments.nvim
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "TODO Next",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "TODO Prev",
    },
  },
}
