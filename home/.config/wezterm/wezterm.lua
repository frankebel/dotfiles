-- Website: https://wezfurlong.org/wezterm
-- Config: https://wezfurlong.org/wezterm/config/lua/config/index.html
-- GitHub: https://github.com/wez/wezterm

local wezterm = require("wezterm")
local act = wezterm.action

return {
  adjust_window_size_when_changing_font_size = false,
  check_for_updates = false,
  command_palette_bg_color = "#44475a",
  command_palette_fg_color = "#bd93f9",
  color_scheme = "Catppuccin Mocha",
  disable_default_key_bindings = true,
  enable_tab_bar = false,
  enable_wayland = false,
  font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Noto Sans Math",
    "Noto Sans Symbols 2",
    "Noto Sans Mono CJK JP",
  }),
  font_size = 13,
  max_fps = 144,
  -- List all keys with `wezterm show-keys --lua`.
  keys = {
    -- Copy/Paste
    { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
    -- Copymode
    { key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
    -- Debug
    { key = "d", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    -- Font size
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
    { key = "=", mods = "CTRL", action = act.ResetFontSize },
    -- Help
    { key = "h", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
    -- Quickselect
    { key = "Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
    -- Scrollback
    { key = "PageUp", action = act.ScrollByPage(-0.5) },
    { key = "PageDown", action = act.ScrollByPage(0.5) },
    {
      key = "k",
      mods = "SHIFT|CTRL",
      action = act.Multiple({
        act.ClearScrollback("ScrollbackAndViewport"),
        act.SendKey({ key = "l", mods = "CTRL" }),
      }),
    },
    -- Search
    { key = "Slash", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
  },
  window_close_confirmation = "NeverPrompt",
}
