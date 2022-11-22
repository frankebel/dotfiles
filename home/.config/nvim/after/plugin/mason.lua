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
    "pyright",
    "sumneko_lua",
  }
}
