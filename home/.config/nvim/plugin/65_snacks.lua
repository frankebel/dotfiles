-- A collection of small QoL plugins for Neovim.
-- https://github.com/folke/snacks.nvim

require("snacks").setup({
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
        packages = {
          "amsmath",
          "amssymb",
          "mathtools",
          "unicode-math",
        },
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
})

local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- bufdelete
nmap("<leader>bd", function()
  Snacks.bufdelete()
end, "Delete current buffer")

-- Top Pickers
nmap("<leader><space>", function()
  Snacks.picker.smart()
end, "SNACKS Smart Find Files")
nmap("<leader>:", function()
  Snacks.picker.command_history()
end, "SNACKS Command History")

-- find
nmap("<leader>fa", function()
  Snacks.picker.files({
    follow = true,
    hidden = true,
    args = { "--no-ignore", "--type", "d" },
  })
end, "SNACKS Find All")
nmap("<leader>fb", function()
  Snacks.picker.buffers()
end, "SNACKS Find Buffers")
nmap("<leader>fd", function()
  Snacks.picker.files({
    follow = true,
    hidden = true,
    args = { "--type", "d" },
    transform = function(item)
      return vim.fn.isdirectory(item.file) == 1
    end,
  })
end, "SNACKS Find Directories")
nmap("<leader>ff", function()
  Snacks.picker.files({
    follow = true,
    hidden = true,
  })
end, "Find Files")
nmap("<leader>fg", function()
  Snacks.picker.grep({
    follow = true,
    hidden = true,
  })
end, "SNACKS Find Grep")
nmap("<leader>fo", function()
  Snacks.picker.recent()
end, "SNACKS Find Old Files")
nmap("<leader>fp", function()
  Snacks.picker.projects()
end, "SNACKS Find Projects")

-- git
nmap("<leader>gs", function()
  Snacks.picker.git_status()
end, "Git Status")

-- Grep
nmap("<leader>sb", function()
  Snacks.picker.lines()
end, "SNACKS Grep Current Buffer")
nmap("<leader>sB", function()
  Snacks.picker.grep_buffers()
end, "SNACKS Grep Open Buffers")

-- search
nmap('<leader>s"', function()
  Snacks.picker.registers()
end, "SNACKS Search Registers")
nmap("<leader>s/", function()
  Snacks.picker.search_history()
end, "SNACKS Search History")
nmap("<leader>sc", function()
  Snacks.picker.command_history()
end, "SNACKS Search Command History")
nmap("<leader>sC", function()
  Snacks.picker.commands()
end, "SNACKS Search Commands")
nmap("<leader>sd", function()
  Snacks.picker.diagnostics_buffer()
end, "SNACKS Search Buffer Diagnostics")
nmap("<leader>sD", function()
  Snacks.picker.diagnostics()
end, "SNACKS Search Diagnostics")
nmap("<leader>sh", function()
  Snacks.picker.help()
end, "SNACKS Search Help")
nmap("<leader>si", function()
  Snacks.picker.icons()
end, "SNACKS Search Icons")
nmap("<leader>sj", function()
  Snacks.picker.jumps()
end, "SNACKS Search Jumps")
nmap("<leader>sk", function()
  Snacks.picker.keymaps()
end, "SNACKS Search Keymaps")
nmap("<leader>sl", function()
  Snacks.picker.loclist()
end, "SNACKS Search Location List")
nmap("<leader>sm", function()
  Snacks.picker.marks()
end, "SNACKS Search Marks")
nmap("<leader>sM", function()
  Snacks.picker.man()
end, "SNACKS Search Man Pages")
nmap("<leader>sq", function()
  Snacks.picker.qflist()
end, "SNACKS Search Quickfix List")
nmap("<leader>sR", function()
  Snacks.picker.resume()
end, "SNACKS Resume last Picker")
nmap("<leader>su", function()
  Snacks.picker.undo()
end, "Undo History")

-- LSP
nmap("gd", function()
  Snacks.picker.lsp_definitions()
end, "Goto Definition")
nmap("gD", function()
  Snacks.picker.lsp_declarations()
end, "Goto Declaration")
nmap("gr", function()
  Snacks.picker.lsp_references()
end, "References")
nmap("gI", function()
  Snacks.picker.lsp_implementations()
end, "Goto Implementation")
nmap("gy", function()
  Snacks.picker.lsp_type_definitions()
end, "Goto T[y]pe Definition")
nmap("<leader>ss", function()
  Snacks.picker.lsp_symbols()
end, "LSP Symbols")
nmap("<leader>sS", function()
  Snacks.picker.lsp_workspace_symbols()
end, "LSP Workspace Symbols")
