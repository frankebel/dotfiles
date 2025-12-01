-- Tree-sitter is a parser generator tool and an incremental parsing library.
-- It can build a concrete syntax tree for a source file and efficiently update
-- the syntax tree as the source file is edited.

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
    version = vim.version.range("*"),
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    version = "main",
  },
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("myconfig.treesitter", { clear = true }),
  pattern = { "nvim-treesitter" },
  callback = function()
    vim.notify("Updating treesitter parsers", vim.log.levels.INFO)
    require("nvim-treesitter").update({ summary = true }):wait(30 * 1000) -- wait at most 30 s
  end,
})

-- install languages
require("nvim-treesitter").install({
  "bash",
  "c",
  "comment",
  "diff",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "json",
  "julia",
  "latex",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "vim",
  "vimdoc",
  "yaml",
})

-- enable treesitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = require("nvim-treesitter").get_installed(),
  callback = function()
    vim.treesitter.start()
  end,
})

-- setup textobjects
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
})

-- text objects: move
local function move_next_start(lhs, obj, desc)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move").goto_next_start(obj, "textobjects")
  end, { desc = desc })
end
move_next_start("]c", "@class.outer", "TS Jump to next class start")
move_next_start("]f", "@function.outer", "TS Jump to next function start")
move_next_start("]p", "@parameter.inner", "TS Jump to next parameter start")

local function move_next_end(lhs, obj, desc)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move").goto_next_end(obj, "textobjects")
  end, { desc = desc })
end
move_next_end("]C", "@class.outer", "TS Jump to next class end")
move_next_end("]F", "@function.outer", "TS Jump to next function end")

local function move_previous_start(lhs, obj, desc)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move").goto_previous_start(obj, "textobjects")
  end, { desc = desc })
end
move_previous_start("[c", "@class.outer", "TS Jump to previous class start")
move_previous_start("[f", "@function.outer", "TS Jump to previous function start")
move_previous_start("[p", "@parameter.inner", "TS Jump to previous parameter start")

local function move_previous_end(lhs, obj, desc)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move").goto_previous_end(obj, "textobjects")
  end, { desc = desc })
end
move_previous_end("[C", "@class.outer", "TS Jump to previous class end")
move_previous_end("[F", "@function.outer", "TS Jump to previous function end")

-- text objects: select
local function sel(lhs, obj, desc)
  vim.keymap.set({ "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
  end, { desc = desc })
end
sel("ac", "@class.outer", "TS Select around class")
sel("af", "@function.outer", "TS Select around function")
sel("ic", "@class.inner", "TS Select inside class")
sel("if", "@function.inner", "TS Select inside function")

-- text objects: swap
vim.keymap.set("n", "<leader>spn", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "TS Swap parameter next" })
vim.keymap.set("n", "<leader>spp", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "TS Swap parameter previous" })
