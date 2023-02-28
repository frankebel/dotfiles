-- Use Mason as package manager for LSP, DAP, linters, formatters.
-- https://github.com/williamboman/mason.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Java
        "jdtls", -- LSP
        "java-debug-adapter", -- DAP
        "java-test", -- DAP
        -- Lua
        "lua-language-server", -- LSP
        -- Python
        "pyright", -- LSP
        "debugpy", -- DAP
        "black", -- formatter
        "flake8", -- linter
        -- Shell
        "shellcheck", -- linter
        "shfmt", -- formatter
      },
    },
  },
}
