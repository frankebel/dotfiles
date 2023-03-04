-- Use Mason as package manager for LSP, DAP, linters, formatters.
-- https://github.com/williamboman/mason.nvim

return {
  {
    "williamboman/mason.nvim",
    config = function()
      local ensure_installed = {
        -- Java
        "jdtls",               -- LSP
        "java-debug-adapter",  -- DAP
        "java-test",           -- DAP
        -- Lua
        "lua-language-server", -- LSP
        -- Python
        "pyright",             -- LSP
        "debugpy",             -- DAP
        "black",               -- formatter
        "flake8",              -- linter
        -- Shell
        "shellcheck",          -- linter
        "shfmt",               -- formatter
      }
      require("mason").setup()
      local mr = require("mason-registry")
      for _, tool in ipairs(ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
