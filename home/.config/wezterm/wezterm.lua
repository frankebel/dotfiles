-- Website: https://wezfurlong.org/wezterm
-- Config: https://wezfurlong.org/wezterm/config/lua/config/index.html
-- GitHub: https://github.com/wez/wezterm

local wezterm = require("wezterm")

return {
  adjust_window_size_when_changing_font_size = false,
  check_for_updates = false,
  color_scheme = "Dracula (Official)",
  default_prog = { os.getenv("SHELL") }, -- Don't append `-l` as in default
  disable_default_key_bindings = true,
  enable_tab_bar = false,
  font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Fira Code",
    "Noto Sans Math",
    "Noto Sans Symbols 2",
  }),
  font_size = 13,
  max_fps = 144,
  keys = {
    -- Copy/Paste
    { key = "C", mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },
    { key = "V", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
    -- Change font size
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "+", mods = "SHIFT|CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.ResetFontSize },
  },
}
