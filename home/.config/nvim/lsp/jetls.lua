-- https://github.com/aviatesk/JETLS.jl

return {
  cmd = {
    "jetls",
    "--threads=auto",
    "--",
  },
  filetypes = { "julia" },
  root_markers = {
    "Project.toml",
    ".git",
  },
}
