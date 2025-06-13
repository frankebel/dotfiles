-- A collection of small QoL plugins for Neovim.
-- https://github.com/folke/snacks.nvim

return {
  "folke/snacks.nvim",
  version = "*",
  lazy = false,
  priority = 1000,
  dependencies = {
    "folke/todo-comments.nvim",
  },
  opts = {
    bigfile = {},
    image = {
      doc = {
        enabled = true,
        max_width = 100,
        max_height = 100,
      },
      math = {
        latex = {
          font_size = "large",
        },
      },
    },
    indent = {
      animate = {
        enabled = false,
      },
    },
    picker = {
      -- list pickers with `:lua Snacks.picker.pick()`
      enabled = true,
      layouts = {
        -- preview layouts with `:lua Snacks.picker.picker_layouts()`
        -- overwrite default layout
        default = {
          layout = {
            box = "horizontal",
            width = 0.9,
            min_width = 120,
            height = 0.9,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
          },
        },
      },
    },
  },
  keys = {
    -- bufdelete
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      "Delete current buffer",
    },
    -- Top Pickers
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "SNACKS Smart Find Files",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "SNACKS Command History",
    },
    -- find
    {
      "<leader>fa",
      function()
        Snacks.picker.files({
          follow = true,
          hidden = true,
          args = { "--no-ignore", "--type", "d" },
        })
      end,
      desc = "SNACKS Find All",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "SNACKS Find Buffers",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.files({
          follow = true,
          hidden = true,
          args = { "--type", "d" },
          transform = function(item)
            return vim.fn.isdirectory(item.file) == 1
          end,
        })
      end,
      desc = "SNACKS Find Directories",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          follow = true,
          hidden = true,
        })
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({
          follow = true,
          hidden = true,
        })
      end,
      desc = "SNACKS Find Grep",
    },
    {
      "<leader>fo",
      function()
        Snacks.picker.recent()
      end,
      desc = "SNACKS Find Old Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "SNACKS Find Projects",
    },
    -- git
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "SNACKS Grep Current Buffer",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "SNACKS Grep Open Buffers",
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "SNACKS Search Registers",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "SNACKS Search History",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "SNACKS Search Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "SNACKS Search Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "SNACKS Search Buffer Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "SNACKS Search Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "SNACKS Search Help",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "SNACKS Search Icons",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "SNACKS Search Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "SNACKS Search Keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "SNACKS Search Location List",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "SNACKS Search Marks",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "SNACKS Search Man Pages",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "SNACKS Search Quickfix List",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "SNACKS Resume last Picker",
    },
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "SNACKS Search TODO",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
  },
}
