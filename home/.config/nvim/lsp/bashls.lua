-- https://github.com/bash-lsp/bash-language-server

return {
  cmd = {
    "bash-language-server",
    "start",
  },
  filetypes = {
    "bash",
    "sh",
  },
  root_markers = {
    ".git",
  },
}
