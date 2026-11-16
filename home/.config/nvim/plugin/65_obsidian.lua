-- Links, backlinks, and daily notes for the Markdown journal.

vim.pack.add({
  {
    src = "https://github.com/obsidian-nvim/obsidian.nvim",
    version = vim.version.range("*"),
  },
})

-- setup() errors without journal directory
local journal = vim.fn.expand("~/data/projects/journal")
if not vim.uv.fs_stat(journal) then
  return
end

require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    { name = "journal", path = journal },
  },
  -- https://obsidian-nvim.github.io/obsidian.nvim/Link
  link = {
    format = "absolute",
    -- root-absolute standard links: `[label](/daily/YYYY/MM/YYYY-MM-DD.md#anchor)`
    -- shortcut: no block links, no URL encoding (slug filenames), no `:Obsidian paste_img`
    style = function(opts)
      local anchor, label = opts.anchor or "", opts.label
      if type(anchor) == "table" then
        -- a heading: its own anchor (nested ones repeat the parents'), its text as fallback label
        anchor, label = (anchor.section or anchor).anchor, label ~= "" and label or anchor.header
      end
      local path = opts.path
      if path ~= "" then
        path = "/" .. path
      end
      return ("[%s](%s%s)"):format(label, path, anchor)
    end,
  },
  completion = { create_new = false },
  daily_notes = { folder = "daily", date_format = "YYYY/MM/YYYY-MM-DD" },
  frontmatter = { enabled = false },
  ui = { enable = false },
  picker = { name = "snacks.picker" },
})

local function jump_day(count)
  -- `daily/YYYY/MM/YYYY-MM-DD.md` paths sort chronologically
  local days = vim.fn.glob(journal .. "/daily/*/*/*.md", false, true)
  table.sort(days)
  local i = vim.fn.index(days, vim.api.nvim_buf_get_name(0)) + 1
  if i == 0 then
    return vim.notify("Not a saved day file of the journal", vim.log.levels.WARN)
  end
  local target = math.min(math.max(i + count, 1), #days) -- clamp
  if target == i then
    return -- already at the first or last day, like `j` on the last line
  end
  vim.cmd.edit(vim.fn.fnameescape(days[target]))
end

-- keymaps
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("myconfig.obsidian", {}),
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    vim.keymap.set("n", "[j", function()
      jump_day(-vim.v.count1)
    end, {
      buffer = ev.buf,
      desc = "Journal: previous existing day",
    })

    vim.keymap.set("n", "]j", function()
      jump_day(vim.v.count1)
    end, {
      buffer = ev.buf,
      desc = "Journal: next existing day",
    })

    -- Headings across the vault; obsidian-ls reports them as kind String, files as File
    vim.keymap.set("n", "<leader>fh", function()
      Snacks.picker.lsp_workspace_symbols({ filter = { markdown = { "String" } } })
    end, {
      buffer = ev.buf,
      desc = "Journal: find headings",
    })
  end,
})
