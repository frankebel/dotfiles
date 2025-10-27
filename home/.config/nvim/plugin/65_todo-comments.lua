-- Highlight and search todo comments.
-- https://github.com/folke/todo-comments.nvim

require("todo-comments").setup()

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "TODO Next" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "TODO Prev" })
