-- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
-- https://github.com/mfussenegger/nvim-lint

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      python = { "flake8", "mypy" },
      sh = { "shellcheck" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft
    -- Customize built-in linter parameters
    local flake8 = lint.linters.flake8
    flake8.args = {
      "--max-line-length",
      "88",
      "--extend-ignore",
      "E203",
    }
    -- Autocmd to trigger linting
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
