-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- awesome libraries
local awful = require("awful")
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

-- Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
  })
end)

-- user files
require("wibar") -- statubar
require("bindings") -- keybindings
require("rules") -- window rules
require("signals") -- signals for window clients
require("notifications") -- notifications
