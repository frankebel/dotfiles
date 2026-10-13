-- Plugin to preview Markdown files live in the browser
vim.pack.add({
  {
    src = "https://github.com/brianhuster/live-preview.nvim",
    version = vim.version.range("*"),
  },
})

require("livepreview.config").set({})
