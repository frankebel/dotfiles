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

require("rules") -- window rules

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
