-- https://github.com/luals/lua-language-server

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".stylua.toml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = {
          "Snacks",
          "vim",
        },
      },
      format = { enable = false },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
