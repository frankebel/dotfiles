vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use lazy as plugin manager
-- https://github.com/folke/lazy.nvim

-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "nvim-mini/mini.nvim",
      version = false,
    },
    {
      "saghen/blink.cmp",
      {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
      },
    },
    {
      "saghen/blink.cmp",
      version = "*",
      dependencies = {
        "erooke/blink-cmp-latex",
      },
    },
    {
      "mfussenegger/nvim-lint",
    },
    {
      "folke/snacks.nvim",
      version = "*",
      lazy = false,
    },
    {
      "catppuccin/nvim",
      version = "*",
      name = "catppuccin",
    },
    {
      "stevearc/conform.nvim",
      version = "*",
    },
    {
      "mikesmithgh/kitty-scrollback.nvim",
      version = "*",
    },
    {
      "stevearc/oil.nvim",
      version = "*",
      lazy = false,
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      version = "*",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    {
      -- https://github.com/nvim-treesitter/nvim-treesitter
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      build = ":TSUpdate",
      cmd = { "TSInstall", "TSUpdate", "TSUninstall" },
      dependencies = {
        {
          -- https://github.com/nvim-treesitter/nvim-treesitter-context
          "nvim-treesitter/nvim-treesitter-context",
          version = "*",
          config = true,
        },
        {
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
          "nvim-treesitter/nvim-treesitter-textobjects",
          branch = "main",
        },
      },
    },
    {
      "lervag/vimtex",
      version = "*",
      lazy = false, -- not recommended to lazy load
    },
  },
  change_detection = { enabled = false },
  install = { colorscheme = { "dracula" } },
  performance = {
    rtp = {
      disabled_pluigns = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
