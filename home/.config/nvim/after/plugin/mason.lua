-- Configuration for mason
-- See https://github.com/williamboman/mason.nvim
require "mason".setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}


-- Configuration for mason-lspconfig
-- See https://github.com/williamboman/mason-lspconfig.nvim
require "mason-lspconfig".setup {
  ensure_installed = {
    "jdtls",
    "pyright",
    "sumneko_lua",
  }
}


-- Configuration for mason-nvim-dap
-- See https://github.com/jayp0521/mason-nvim-dap.nvim
require "mason-nvim-dap".setup {
  ensure_installed = {
    "python",
    "javadbg",
    "javatest",
  }
}


-- Configuration for mason-null-ls
-- See https://github.com/jayp0521/mason-null-ls.nvim
require "mason-null-ls".setup {
  ensure_installed = {
    -- Python
    "autopep8",
    "flake8",

    -- Sh
    "shellcheck",
    "shfmt",
  }
}
