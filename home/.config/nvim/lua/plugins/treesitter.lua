-- Tree-sitter is a parser generator tool and an incremental parsing library.
-- It can build a concrete syntax tree for a source file and efficiently update
-- the syntax tree as the source file is edited.
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- version = "*",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        -- https://github.com/nvim-treesitter/playground
        "nvim-treesitter/playground",
        build = ":TSInstall query",
        cmd = "TSPlaygroundToggle",
      },
      {
        -- https://github.com/nvim-treesitter/nvim-treesitter-context
        "nvim-treesitter/nvim-treesitter-context",
        config = true,
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      -- A list of parser names, or "all"
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "diff",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {
        -- vimtex does not recommend treesitter
        "latex",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "grc",
          node_decremental = "<bs>",
        },
      },

      -- nvim-treesiter-textobjects
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]p"] = { query = "@parameter.inner", desc = "TS Jump to next parameter" },
            ["]i"] = { query = "@conditional.outer", desc = "TS Jump to next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "TS Jump to next loop start" },
            ["]f"] = { query = "@function.outer", desc = "TS Jump to next function start" },
            ["]c"] = { query = "@class.outer", desc = "TS Jump to next class start" },
          },
          goto_next_end = {
            ["]I"] = { query = "@conditional.outer", desc = "TS Jump to next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "TS Jump to next loop end" },
            ["]F"] = { query = "@function.outer", desc = "TS Jump to next function end" },
            ["]C"] = { query = "@class.outer", desc = "TS Jump to next class end" },
          },
          goto_previous_start = {
            ["[p"] = { query = "@parameter.inner", desc = "TS Jump to previous parameter" },
            ["[i"] = { query = "@conditional.outer", desc = "TS Jump to previous conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "TS Jump to previous loop start" },
            ["[f"] = { query = "@function.outer", desc = "TS Jump to previous function start" },
            ["[c"] = { query = "@class.outer", desc = "TS Jump to previous class start" },
          },
          goto_previous_end = {
            ["[I"] = { query = "@conditional.outer", desc = "TS Jump to previous conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "TS Jump to previous loop end" },
            ["[F"] = { query = "@function.outer", desc = "TS Jump to previous function end" },
            ["[C"] = { query = "@class.outer", desc = "TS Jump to previous class end" },
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assginment.outer", desc = "TS Select around assginment" },
            ["i="] = { query = "@assignment.inner", desc = "TS Select inside assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "TS Select left side assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "TS Select right side assignment" },
            ["ai"] = { query = "@conditional.outer", desc = "TS Select around conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "TS Select inner conditional" },
            ["al"] = { query = "@loop.outer", desc = "TS Select outer loop" },
            ["il"] = { query = "@loop.inner", desc = "TS Select inner loop" },
            ["af"] = { query = "@function.outer", desc = "TS Select around function" },
            ["if"] = { query = "@function.inner", desc = "TS Select inside function" },
            ["ic"] = { query = "@class.inner", desc = "TS Select inside class" },
            ["ac"] = { query = "@class.outer", desc = "TS Select around class" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>spn"] = { query = "@parameter.inner", desc = "TS Swap parameter next" },
            ["<leader>sfn"] = { query = "@function.outer", desc = "TS Swap function next" },
            ["<leader>scn"] = { query = "@class.outer", desc = "TS Swap class next" },
          },
          swap_previous = {
            ["<leader>spp"] = { query = "@parameter.inner", desc = "TS Swap parameter previous" },
            ["<leader>sfp"] = { query = "@function.outer", desc = "TS Swap function previous" },
            ["<leader>scp"] = { query = "@class.outer", desc = "TS Swap class previous" },
          },
        },
      },

      -- https://github.com/nvim-treesitter/playground
      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
