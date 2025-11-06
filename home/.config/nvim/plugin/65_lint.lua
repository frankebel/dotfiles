-- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
-- https://github.com/mfussenegger/nvim-lint

local lint = require("lint")

lint.linters_by_ft = {
  sh = { "shellcheck" },
}

-- Autocmd to trigger linting
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
