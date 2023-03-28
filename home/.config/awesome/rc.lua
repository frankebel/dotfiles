-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- awesome libraries
local beautiful = require("beautiful")
local gears = require("gears")
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

-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/dracula.lua")

-- This is used later as the default terminal and editor to run.
local terminal = os.getenv("TERMINAL")
-- Modifier keys.
local mod = {
  alt = "Mod1",
  super = "Mod4",
  altgr = "Mod5",
  shift = "Shift",
  ctrl = "Control",
}

-- user files
require("layouts") -- List of layouts
require("wibar") -- statubar
require("bindings") -- keybindings
require("rules") -- window rules
require("signals") -- signals for window clients
require("notifications") -- notifications
