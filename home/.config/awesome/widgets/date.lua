-- Create a date widget.

-- Awesome libraries
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

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

return mydate
