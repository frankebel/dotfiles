-- Use packer as plugin/package manager
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Run `PackerSync` whenever this file is updated
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Install plugins
return require("packer").startup(function(use)
  -- packer
  use "wbthomason/packer.nvim"

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    tag = "v0.*",
  }
  use "onsails/lspkind.nvim" -- pictograms
  -- luasnip
  use {
    "L3MON4D3/LuaSnip",
    tag = "v1.*",
  }
  use "saadparwaiz1/cmp_luasnip"
  -- completion plugins
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    tag = "v0.*"
  }
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.*",
    requires = { "nvim-lua/plenary.nvim" },
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = { "nvim-treesitter" },
  }
  use {
    "nvim-treesitter/playground",
    run = ":TSInstall query"
  }

  -- Filetype specific
  -- markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    ft = "markdown",
    tag = "v0.*",
  }

  -- Uncategorized
  use "Mofiqul/dracula.nvim" -- Colorscheme
  -- Commenting
  use {
    "numToStr/Comment.nvim",
    tag = "v0.*",
  }
  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    tag = "v0.*",
  }
  -- Code actions
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }
  -- File manager
  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
    tag = "nightly",
  }
  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  }

  -- Put after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
