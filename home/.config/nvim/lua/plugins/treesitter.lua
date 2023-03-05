-- Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
        event = "BufReadPre",
        config = true,
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          "bash",
          "comment",
          "diff",
          "git_rebase",
          "gitcommit",
          "gitignore",
          "help",
          "java",
          "json",
          "latex",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "vim",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- nvim-treesiter-textobjects
        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                  ["]p"] = { query = "@parameter.inner", desc = "Jump to next parameter" },
                  ["]f"] = { query = "@function.outer", desc = "Jump to next function start" },
                  ["]c"] = { query = "@class.outer", desc = "Jump to next class start" },
            },
            goto_next_end = {
                  ["]F"] = { query = "@function.outer", desc = "Jump to next function end" },
                  ["]C"] = { query = "@class.outer", desc = "Jump to next class end" },
            },
            goto_previous_start = {
                  ["[p"] = { query = "@parameter.inner", desc = "Jump to previous parameter" },
                  ["[f"] = { query = "@function.outer", desc = "Jump to previous function start" },
                  ["[c"] = { query = "@class.outer", desc = "Jump to previous class start" },
            },
            goto_previous_end = {
                  ["[F"] = { query = "@function.outer", desc = "Jump to previous function end" },
                  ["[C"] = { query = "@class.outer", desc = "Jump to previous class end" },
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
                  ["af"] = { query = "@function.outer", desc = "Select around function" },
                  ["if"] = { query = "@function.inner", desc = "Select inside function" },
                  ["ic"] = { query = "@class.inner", desc = "Select inside class" },
                  ["ac"] = { query = "@class.outer", desc = "Select around class" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
                  ["<leader>spn"] = { query = "@parameter.inner", desc = "Swap parameter next" },
                  ["<leader>sfn"] = { query = "@function.outer", desc = "Swap function next" },
                  ["<leader>scn"] = { query = "@class.outer", desc = "Swap class next" },
            },
            swap_previous = {
                  ["<leader>spp"] = { query = "@parameter.inner", desc = "Swap parameter previous" },
                  ["<leader>sfp"] = { query = "@function.outer", desc = "Swap function previous" },
                  ["<leader>scp"] = { query = "@class.outer", desc = "Swap class previous" },
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
      }
    end
  },
}
