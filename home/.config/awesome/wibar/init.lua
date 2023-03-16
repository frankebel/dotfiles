-- Statusbar

-- Awesome libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus") -- focus after closing window
local wibox = require("wibox")

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

-- Not sure why, but awful.widget.watch can't be last widget.
-- Need dummy widget as last widget.
local widgetlast = wibox.widget.textbox()
widgetlast.text = ""

-- Right widgets
local widgets_right = {
  layout = wibox.layout.fixed.horizontal,
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
  awful.widget.watch("bash -c " .. widgets_path .. "datetime", 1),
  widgetlast,
}
if not is_laptop() then
  -- Remove battery widget.
  table.remove(widgets_right, 3)
  table.remove(widgets_right, 3)
end

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
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
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    {
      -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    widgets_right,
  })
end)
