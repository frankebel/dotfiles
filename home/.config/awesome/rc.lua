-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- awesome libraries
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
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
-- Function to get hostname
local function gethostname()
  local f = assert(io.popen("uname -n", "r"))
  local s = assert(f:read("*a"))
  f:close()
  s = s:gsub("\n", "") -- Remove linebreak.
  return s
end
-- Function to check if hostname contains string "laptop"
local function is_laptop()
  local hostname = gethostname()
  if string.match(hostname, "laptop") then
    return true
  else
    return false
  end
end

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

-- Wibar
-- Set path for custom widgets.
local widgets_path = "~/.local/bin/statusbar/"

-- Create a separator widget
local mysep = wibox.widget.separator({
  orientation = "vertical",
  span_ratio = 0.9,
  forced_width = 10,
})

-- Create a clock widget
local myclock = wibox.widget({
  {
    {
      format = " %T",
      refresh = 1,
      widget = wibox.widget.textclock,
    },
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin,
  },
  shape = gears.shape.rounded_bar,
  bg = beautiful.widget_bg,
  fg = beautiful.widget_fg2,
  widget = wibox.container.background,
})

-- Create a date widget
local mydate = wibox.widget({
  {
    {
      format = " %F (%a)",
      refresh = 3600,
      widget = wibox.widget.textclock,
    },
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin,
  },
  shape = gears.shape.rounded_bar,
  bg = beautiful.widget_bg,
  fg = beautiful.widget_fg1,
  widget = wibox.container.background,
})

-- Right widgets
local widgets_right = {
  wibox.widget.systray(),
  mysep,
  awful.widget.watch("bash -c " .. widgets_path .. "battery", 1),
  mysep,
  awful.widget.watch("bash -c " .. widgets_path .. "mail", 1),
  mysep,
  awful.widget.watch("bash -c " .. widgets_path .. "volumemic", 1),
  mysep,
  awful.widget.watch("bash -c " .. widgets_path .. "volume", 1),
  mysep,
  mydate,
  myclock,
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(8),
}
if not is_laptop() then
  -- Remove battery widget.
  table.remove(widgets_right, 3)
  table.remove(widgets_right, 3)
end

screen.connect_signal("request::desktop_decoration", function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
  })

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
  })

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    widget = {
      layout = wibox.layout.align.horizontal,
      -- Left widgets
      {
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
      },
      -- Middle widget
      s.mytasklist,
      -- Right widgets
      widgets_right,
    },
  })
end)

-- user files
require("bindings") -- keybindings
require("rules") -- window rules
require("signals") -- signals for window clients
require("notifications") -- notifications
