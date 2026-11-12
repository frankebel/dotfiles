-- Plugin to preview Markdown files live in the browser
vim.pack.add({
  {
    src = "https://github.com/frankebel/live-preview.nvim",
    -- shortcut: fork branch for brianhuster/live-preview.nvim#392,
    -- back to upstream + range("*") once a release contains it
    version = "super-subscripts",
  },
})

-- Ask the OS for a free port, so that each Neovim session gets its own server
local tcp = vim.uv.new_tcp()
tcp:bind("127.0.0.1", 0)
local port = tcp:getsockname().port
tcp:close()

require("livepreview.config").set({ port = port })
