-- Interactive Repls over neovim

vim.pack.add({
  {
    src = "https://github.com/Vigemus/iron.nvim",
  },
})

local iron = require("iron.core")
local common = require("iron.fts.common")

iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      julia = {
        command = { "julia" },
        format = common.bracketed_paste,
        block_dividers = { "##", "# %%" },
      },
    },
    repl_filetype = function(_, ft)
      return ft
    end,
    dap_integration = true,
    repl_open_cmd = function(bufnr)
      -- Pin code windows to 92 text columns (numberwidth + 2 * signcolumn).
      -- The REPL opens directly at the remainder to the very right.

      -- signcolumn=yes (without specified number) reserves one column
      local sign_cols = tonumber(vim.o.signcolumn:match(":(%d+)")) or (vim.o.signcolumn == "yes" and 1 or 0)
      local width = 92 + vim.wo.numberwidth + 2 * sign_cols

      -- all windows except REPL, quickfix
      local code_wins = vim.tbl_filter(function(w)
        local b = vim.api.nvim_win_get_buf(w)
        return b ~= bufnr and vim.bo[b].buftype ~= "quickfix"
      end, vim.api.nvim_list_wins())

      local repl_w = math.max(1, vim.o.columns - (width + 1) * #code_wins) -- window separator of width 1

      -- rightmost window
      local rightmost
      for win in vim.iter(code_wins) do
        if not rightmost or vim.api.nvim_win_get_position(win)[2] > vim.api.nvim_win_get_position(rightmost)[2] then
          rightmost = win
        end
      end

      -- create REPL as rightmost window
      vim.api.nvim_set_current_win(rightmost)
      local repl = vim.api.nvim_open_win(bufnr, false, { split = "right" })

      -- resize windows
      for win in vim.iter(code_wins) do
        vim.api.nvim_win_set_width(win, width)
      end
      vim.api.nvim_win_set_width(repl, repl_w)

      return repl
    end,
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
