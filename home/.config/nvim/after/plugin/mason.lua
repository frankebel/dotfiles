-- Configuration for mason
-- https://github.com/williamboman/mason.nvim

local status_mason, mason = pcall(require, "mason")
if not status_mason then
  return
end

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}


-- Configuration for mason-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  return
end

mason_lspconfig.setup {
  ensure_installed = {
    "jdtls",
    "pyright",
    "sumneko_lua",
  }
}


-- Configuration for mason-nvim-dap
-- https://github.com/jayp0521/mason-nvim-dap.nvim

local status_mnd, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not status_mnd then
  return
end

mason_nvim_dap.setup {
  ensure_installed = {
    "python",
    "javadbg",
    "javatest",
  }
}


-- Configuration for mason-null-ls
-- https://github.com/jayp0521/mason-null-ls.nvim

local status_mnl, mason_null_ls = pcall(require, "mason-null-ls")
if not status_mnl then
  return
end

mason_null_ls.setup {
  ensure_installed = {
    -- Python
    "autopep8",
    "flake8",

    -- Sh
    "shellcheck",
    "shfmt",
  }
}
