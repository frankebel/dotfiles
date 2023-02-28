-- Debug Adapter Protocol DAP
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/theHamsta/nvim-dap-virtual-text

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "DAP Toggle Breakpoint"
      },
      { "<leader>dc", function() require("dap").continue() end,          desc = "DAP Continue" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "DAP Step Into" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "DAP Step Over" },
      { "<leader>du", function() require("dap").step_out() end,          desc = "DAP Step Out" },
      { "<leader>dq", function() require("dap").terminate() end,         desc = "DAP Quit" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
  },
}
