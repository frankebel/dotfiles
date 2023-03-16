-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- Awesome libraries
local awful = require("awful")
require("awful.autofocus") -- focus after closing window
local beautiful = require("beautiful")

-- Error handling
require("handling")

-- Load custom theme
require("themes")

-- List of layouts
require("layouts")


-- Set keymaps
local keys = require("keys")
root.keys(keys.globalkeys)

-- Statubar
require("wibar")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- Use command "xprop WM_CLASS"
-- First string will be the instance, second string the class.
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.clientkeys,
      buttons = keys.clientbuttons,
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

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Mark active window with border.
client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}
