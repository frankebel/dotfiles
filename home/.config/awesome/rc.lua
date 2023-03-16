-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- Awesome libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus") -- focus after closing window
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Error handling
require("handling")

-- Load custom theme
require("themes")

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

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
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
}

-- {{{ Wibar
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
-- }}}

-- Set keymaps
local keys = require("keys")
root.keys(keys.globalkeys)

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
