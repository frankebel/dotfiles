-- Interactive Repls over neovim

vim.pack.add({
  {
    src = "https://github.com/Vigemus/iron.nvim",
  },
})

local iron = require("iron.core")
local view = require("iron.view")
local common = require("iron.fts.common")

iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      julia = {
        command = { "julia" },
        format = common.bracketed_paste,
        block_dividers = { "# %%", "#%%" },
      },
    },
    repl_filetype = function(_, ft)
      return ft
    end,
    dap_integration = true,
    repl_open_cmd = {
      view.split.vertical.rightbelow(function()
        -- max 40 % of column width but 80 columns minimum
        local limit = 80
        return math.max(limit, math.min(vim.o.columns * 0.4, limit))
      end),
    },
  },
  keymaps = {
    toggle_repl = "<leader>ir",
    restart_repl = "<leader>iR",
    send_motion = "<leader>im",
    visual_send = "<leader>iv",
    send_file = "<leader>if",
    send_line = "<leader>il",
    send_paragraph = "<leader>ip",
    send_until_cursor = "<leader>iuc",
    send_mark = "<leader>im",
    send_code_block = "<leader>ib",
    send_code_block_and_move = "<leader>in",
    interrupt = "<leader>cc",
    exit = "<leader>iq",
    clear = "<leader>ic",
  },
  highlight = {
    italic = true,
  },
  ignore_blank_lines = true,
})
