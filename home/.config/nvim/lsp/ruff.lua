-- https://github.com/astral-sh/ruff

return {
  cmd = {
    "ruff",
    "server",
  },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    ".git",
  },
}
