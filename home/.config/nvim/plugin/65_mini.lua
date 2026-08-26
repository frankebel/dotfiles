-- Library of 40+ independent Lua modules

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.nvim",
    version = "main",
  },
})

local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- General workflow
require("mini.diff").setup()
nmap("<leader>go", function()
  require("mini.diff").toggle_overlay(0)
end, "mini toggle git overlay")

require("mini.git").setup()

-- Appearance
require("mini.icons").setup()
