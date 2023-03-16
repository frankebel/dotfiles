-- Keymaps

-- Required modules
local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Modifier keys
-- local alt = "Mod1" -- Alt key
local super = "Mod4" -- Super key
-- local altgr = "Mod5" -- AltGr key
local shift = "Shift"
local control = "Control"

local terminal = os.getenv("TERMINAL")

local M = {}

M.globalkeys = gears.table.join(
  awful.key({ super }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ super }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ super }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ super }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key({ super }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ super }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),

  -- Layout manipulation
  awful.key({ super, shift }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ super, shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),
  awful.key({ super }, "]", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ super }, "[", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ super }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

  -- Standard program
  awful.key({ super, control }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ super, control }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ super }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ super }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ super, shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ super, shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ super, control }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ super, control }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
  awful.key({ super }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ super, shift }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  -- Launch applications
  awful.key({ super }, "Return", function()
    awful.spawn(terminal)
  end, { description = "lauch terminal", group = "applications" }),
  awful.key({ super, shift }, "Return", function()
    awful.spawn("rofi -show run")
  end, { description = "launch rofi", group = "applications" }),
  awful.key({ super }, "b", function()
    awful.spawn(os.getenv("BROWSER"))
  end, { description = "launch browser", group = "applications" }),
  awful.key({ super }, "i", function()
    awful.spawn(terminal .. " start htop")
  end, { description = "launch htop", group = "applications" }),
  awful.key({ super }, "m", function()
    awful.spawn(terminal .. " start neomutt")
  end, { description = "launch mail", group = "applications" }),
  awful.key({ super }, "n", function()
    awful.spawn(terminal .. " start newsboat")
  end, { description = "launch newsboat", group = "applications" }),
  awful.key({ super }, "p", function()
    awful.spawn("rofi-pass")
  end, { description = "launch pass", group = "applications" }),
  awful.key({ super }, "s", function()
    awful.spawn("steam")
  end, { description = "launch steam", group = "applications" }),
  awful.key({ super }, "v", function()
    awful.spawn(terminal .. " start " .. os.getenv("EDITOR"))
  end, { description = "launch editor", group = "applications" }),
  awful.key({ super }, "x", function()
    awful.spawn("xournalpp")
  end, { description = "launch xournalpp", group = "applications" }),
  awful.key({}, "Print", function()
    awful.spawn("flameshot gui")
  end, { description = "launch flameshot gui", group = "applications" }),
  awful.key({ super }, "F12", function()
    awful.spawn("i3lock --color=282a36 -u")
  end, { description = "lock screen", group = "applications" }),
  awful.key({ super }, "z", function()
    awful.spawn("kblayout")
  end, { description = "change keyboard layout", group = "applications" }),

  -- Volume keys
  awful.key({}, "XF86AudioMute", function()
    awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
  end, { description = "mute audio", group = "volume" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
  end, { description = "lower volume", group = "volume" }),
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
  end, { description = "raise volume", group = "volume" }),
  awful.key({ super }, "/", function()
    awful.spawn("micmute")
  end, { description = "toggle mic mute", group = "volume" }),

  -- Brightness keys
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("xbacklight -dec 10")
  end, { description = "lower brightness", group = "brightness" }),
  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn("xbacklight -inc 10")
  end, { description = "raise brightness", group = "brightness" }),

  -- Background processes
  awful.key({ super, shift }, "r", function()
    awful.spawn("gpg-connect-agent reloadagent /bye")
  end, { description = "reload gpg agent", group = "background processes" }),
  awful.key({ super, shift }, "s", function()
    awful.spawn("backgroundstart")
  end, { description = "start background processes", group = "background processes" }),
  awful.key({ super, shift }, "q", function()
    awful.spawn("backgroundstop")
  end, { description = "stop background processes", group = "background processes" }),

  -- Notifications
  awful.key({ control }, "space", function()
    awful.spawn("dunstctl close")
  end, { description = "close notification", group = "notifications" }),
  awful.key({ control, shift }, "space", function()
    awful.spawn("dunstctl close-all")
  end, { description = "close all notifications", group = "notifications" }),
  awful.key({ control }, "`", function()
    awful.spawn("dunstctl history-pop")
  end, { description = "open notification", group = "notifications" })
)

M.clientkeys = gears.table.join(
  awful.key({ super, shift }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ super }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { super, control },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ super, control }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ super }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ super }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ super }, "f", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  M.globalkeys = gears.table.join(
    M.globalkeys,
    -- View tag only.
    awful.key({ super }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ super, control }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ super, shift }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ super, control, shift }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

M.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ super }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ super }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

return M
