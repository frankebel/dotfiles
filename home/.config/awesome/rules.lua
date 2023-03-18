-- Rules for window spawning
-- Use command "xprop WM_CLASS"
-- First string will be the instance, second string the class.

-- Awesome libraries
local awful = require("awful")
local beautiful = require("beautiful")

-- custom bindings
local clientkeys = require("bindings.client.keys")
local clientbuttons = require("bindings.client.mouse")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Gpick",
        "Kruler",
        "MessageWin", -- kalarm.
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  },

  -- Fullscreen applications.
  {
    rule_any = {
      class = {
        "mpv",
      },
    },
    properties = { fullscreen = true },
  },

  -- Games
  {
    rule_any = {
      class = {
        "Minecraft* 1.18.2",
        "steam_app_1446780", -- Monster Hunter Rise
        "steam_app_548430", -- Deep Rock Galactic
      },
    },
    properties = {
      floating = true,
      fullscreen = true,
      ontop = true,
    },
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}
