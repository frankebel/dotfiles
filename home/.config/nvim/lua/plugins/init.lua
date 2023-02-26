return {
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    version = "v0.*",
  },
  "onsails/lspkind.nvim", -- pictograms
  -- luasnip
  {
    "L3MON4D3/LuaSnip",
    version = "v1.*",
  },
  "saadparwaiz1/cmp_luasnip",
  -- completion plugins
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- DAP
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",

  -- LSP
  "neovim/nvim-lspconfig",

  -- Mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig",
  "jayp0521/mason-nvim-dap.nvim",
  "jayp0521/mason-null-ls.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },
  "nvim-treesitter/nvim-treesitter-context",
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
  },
  {
    "nvim-treesitter/playground",
    build = ":TSInstall query"
  },

  -- Filetype specific
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    version = "v0.*",
  },
  -- Java
  "mfussenegger/nvim-jdtls",
  -- Tridactyl
  "tridactyl/vim-tridactyl",

  -- Uncategorized
  "Mofiqul/dracula.nvim", -- Colorscheme
  -- Commenting
  {
    "numToStr/Comment.nvim",
    version = "v0.*",
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    version = "v0.*",
  },
  -- Code actions
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- File manager
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "nightly",
  },
}
