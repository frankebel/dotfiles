-- https://github.com/aviatesk/JETLS.jl

return {
  cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    "--project=~/.julia/environments/jetls/",
    "--threads=auto",
    os.getenv("HOME") .. "/.julia/environments/jetls/runserver.jl",
  },
  filetypes = { "julia" },
  root_markers = {
    "Project.toml",
    ".git",
  },
}
