-- Options
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt_local.spell = true

vim.keymap.set("n", "<leader>m", function()
  -- The first preview opens a window on the current workspace, next to Neovim.
  -- Later ones a tab in the most recently used browser window.
  local flag = require("livepreview").is_running() and " --new-tab" or " --new-window"
  require("livepreview.config").config.browser = vim.env.BROWSER .. flag
  require("keep_focus")(function()
    vim.cmd.LivePreview("start")
  end)
end, { buffer = 0, desc = "LIVEPREVIEW start" })
