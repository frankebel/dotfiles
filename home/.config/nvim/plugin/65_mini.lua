-- Library of 40+ independent Lua modules

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.nvim",
    version = "main",
  },
})

local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = 0 })
end

-- General workflow
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = {
      add = "┃",
      change = "┃",
      delete = "┃",
    },
  },
})
nmap("<leader>go", function()
  require("mini.diff").toggle_overlay(0)
end, "mini.diff toggle overlay")

require("mini.git").setup()

-- Appearance
require("mini.icons").setup()
