-- Configure DAP
-- https://github.com/mfussenegger/nvim-dap

local status_dap, dap = pcall(require, "dap")
if not status_dap then
  return
end

-- Python
dap.adapters.python = {
  type = "executable";
  command = os.getenv("XDG_DATA_HOME") .. "/nvim/mason/packages/debugpy/venv/bin/python";
  args = { "-m", "debugpy.adapter" };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python"; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch";
    name = "Launch file";

    -- Options below are for debugpy, https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- Look for ".venv" in working directory.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python"
      end
    end;
  },
}


-- Configure nvim-dap-ui
-- https://github.com/rcarriga/nvim-dap-ui
local status_dapui, dapui = pcall(require, "dapui")
if not status_dapui then
  return
end

dapui.setup()

-- Open and close windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close {}
end


-- Configure nvim-dap-virtual-text
-- https://github.com/theHamsta/nvim-dap-virtual-text
local status_ndvt, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ndvt then
  return
end
nvim_dap_virtual_text.setup {}


-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toogle breakpoint" })
keymap("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))end, { desc = "Set breakpoint with condition" })
keymap("n", "<F1>", dap.step_back, { desc = "Step back" })
keymap("n", "<F2>", dap.step_into, { desc = "Step into" })
keymap("n", "<F3>", dap.step_over, { desc = "Step over" })
keymap("n", "<F4>", dap.step_out, { desc = "Step out" })
keymap("n", "<F5>", dap.continue, { desc = "Continue" })
keymap("n", "<F6>", dap.close, { desc = "Close DAP" })
keymap("n", "<F7>", dap.terminate, { desc = "Terminate DAP" })
keymap("n", "<F8>", dapui.close, { desc = "Close dapui" })
