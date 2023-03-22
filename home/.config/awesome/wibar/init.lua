-- Statusbar

-- Awesome libraries
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

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

-- Set path for custom widgets.
local widgets_path = "~/.local/bin/statusbar/"

-- Create a separator widget
local mysep = wibox.widget.separator({
  orientation = "vertical",
  span_ratio = 0.9,
  forced_width = 10,
})

local mydate = require("widgets.date") -- date widget
local myclock = require("widgets.clock") -- clock widget

-- Not sure why, but awful.widget.watch can't be last widget.
-- Need dummy widget as last widget.
local widgetlast = wibox.widget.textbox()
widgetlast.text = ""

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
  widgetlast,
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
