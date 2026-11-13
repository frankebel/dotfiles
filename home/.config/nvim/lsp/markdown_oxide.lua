-- See https://github.com/Feel-ix-343/markdown-oxide#Neovim

return {
  cmd = { "markdown-oxide" },
  filetypes = { "markdown" },
  root_markers = {
    ".git",
    ".obsidian",
    ".moxide.toml",
  },
  capabilities = {
    workspace = {
      -- off by default on Linux, needed to pick up new and renamed files
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}
