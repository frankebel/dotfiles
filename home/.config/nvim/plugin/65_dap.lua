-- Debug Adapter Protocol DAP.
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/theHamsta/nvim-dap-virtual-text
-- https://github.com/mfussenegger/nvim-dap-python

local dap = require("dap")
-- Set up  nvim-dap-ui
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

-- keymaps
local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

nmap("<leader>db", function()
  require("dap").toggle_breakpoint()
end, "DAP Toggle Breakpoint")
nmap("<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "DAP Set Conditional Breakpoint")
nmap("<leader>dc", function()
  require("dap").continue()
end, "DAP Continue")
nmap("<leader>di", function()
  require("dap").step_into()
end, "DAP Step Into")
nmap("<leader>do", function()
  require("dap").step_over()
end, "DAP Step Over")
nmap("<leader>du", function()
  require("dap").step_out()
end, "DAP Step Out")
nmap("<leader>dq", function()
  require("dap").terminate()
end, "DAP Quit")
