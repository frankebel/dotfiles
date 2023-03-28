-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- awesome libraries
local naughty = require("naughty")
require("awful.autofocus") -- focus after closing window

-- Error handling
-- Check if awesome encountered an error during startup and fall back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification({
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  })
end)

-- user files
require("themes") -- Load custom theme
require("layouts") -- List of layouts
require("wibar") -- statubar
require("bindings") -- keybindings
require("rules") -- window rules
require("signals") -- signals for window clients
require("notifications") -- notifications
