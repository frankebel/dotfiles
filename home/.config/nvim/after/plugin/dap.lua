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
-- See https://github.com/rcarriga/nvim-dap-ui
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
-- See https://github.com/theHamsta/nvim-dap-virtual-text
local status_ndvt, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ndvt then
  return
end
nvim_dap_virtual_text.setup {}
