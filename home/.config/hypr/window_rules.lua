-- https://wiki.hyprland.org/Configuring/Basics/Window-Rules/

hl.window_rule({
  name = "games",
  match = {
    class = "^steam_app_([0-9]+)$",
  },
  idle_inhibit = "fullscreen",
})

hl.window_rule({
  name = "imv",
  match = {
    class = "^(imv)$",
  },
  maximize = true,
})

hl.window_rule({
  name = "hyprland-share-picker",
  match = {
    class = "^(hyprland-share-picker)$",
  },
  float = true,
})

hl.window_rule({
  name = "steam",
  match = {
    title = "^()$",
    class = "^(steam)$",
  },
  stay_focused = true,
  min_size = { 1, 1 },
})

hl.window_rule({
  name = "tor-browser",
  match = {
    class = "^(Tor Browser)$",
  },
  float = true,
})

hl.window_rule({
  name = "zathura",
  match = {
    class = "^(org.pwmt.zathura)$",
  },
  group = "set always",
})
