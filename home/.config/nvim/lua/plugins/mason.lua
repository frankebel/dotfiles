-- Use Mason as package manager for LSP, DAP, linters, formatters.
-- https://github.com/williamboman/mason.nvim

return {
  {
    "williamboman/mason.nvim",
    version = "*",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        -- Java
        "jdtls", -- LSP
        "java-debug-adapter", -- DAP
        "java-test", -- DAP
        -- LaTeX
        "latexindent",
        -- Lua
        "lua-language-server", -- LSP
        "stylua", -- formatter
        -- Markdown
        "prettierd", -- formatter
        -- Python
        "pyright", -- LSP
        "debugpy", -- DAP
        "black", -- formatter
        "flake8", -- linter
        "mypy", -- linter
        -- Shell
        "shellcheck", -- linter
        "shfmt", -- formatter
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
