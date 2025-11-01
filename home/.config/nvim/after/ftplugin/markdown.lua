-- Options
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt_local.spell = true

require("render-markdown").setup({
  sign = {
    enabled = false,
  },
})

vim.keymap.set("n", "<leader>m", function()
  require("render-markdown").toggle()
end, { desc = "Toggle render-markdown" })
