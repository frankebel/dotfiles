-- Keymaps

-- Required modules
local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Some settings
local modkey = "Mod4" -- super key as modfier
local terminal = os.getenv("TERMINAL")

local M = {}

M.globalkeys = gears.table.join(
  awful.key({ modkey }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey }, "]", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey }, "[", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

  -- Standard program
  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Control" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  -- Launch applications
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "lauch terminal", group = "applications" }),
  awful.key({ modkey, "Shift" }, "Return", function()
    awful.spawn("rofi -show run")
  end, { description = "launch rofi", group = "applications" }),
  awful.key({ modkey }, "b", function()
    awful.spawn(os.getenv("BROWSER"))
  end, { description = "launch browser", group = "applications" }),
  awful.key({ modkey }, "i", function()
    awful.spawn(terminal .. " start htop")
  end, { description = "launch htop", group = "applications" }),
  awful.key({ modkey }, "m", function()
    awful.spawn(terminal .. " start neomutt")
  end, { description = "launch mail", group = "applications" }),
  awful.key({ modkey }, "n", function()
    awful.spawn(terminal .. " start newsboat")
  end, { description = "launch newsboat", group = "applications" }),
  awful.key({ modkey }, "p", function()
    awful.spawn("rofi-pass")
  end, { description = "launch pass", group = "applications" }),
  awful.key({ modkey }, "s", function()
    awful.spawn("steam")
  end, { description = "launch steam", group = "applications" }),
  awful.key({ modkey }, "v", function()
    awful.spawn(terminal .. " start " .. os.getenv("EDITOR"))
  end, { description = "launch editor", group = "applications" }),
  awful.key({ modkey }, "x", function()
    awful.spawn("xournalpp")
  end, { description = "launch xournalpp", group = "applications" }),
  awful.key({}, "Print", function()
    awful.spawn("flameshot gui")
  end, { description = "launch flameshot gui", group = "applications" }),
  awful.key({ modkey }, "F12", function()
    awful.spawn("i3lock --color=282a36 -u")
  end, { description = "lock screen", group = "applications" }),
  awful.key({ modkey }, "z", function()
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
  awful.key({ modkey }, "/", function()
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
  awful.key({ modkey, "Shift" }, "r", function()
    awful.spawn("gpg-connect-agent reloadagent /bye")
  end, { description = "reload gpg agent", group = "background processes" }),
  awful.key({ modkey, "Shift" }, "s", function()
    awful.spawn("backgroundstart")
  end, { description = "start background processes", group = "background processes" }),
  awful.key({ modkey, "Shift" }, "q", function()
    awful.spawn("backgroundstop")
  end, { description = "stop background processes", group = "background processes" }),

  -- Notifications
  awful.key({ "Control" }, "space", function()
    awful.spawn("dunstctl close")
  end, { description = "close notification", group = "notifications" }),
  awful.key({ "Control", "Shift" }, "space", function()
    awful.spawn("dunstctl close-all")
  end, { description = "close all notifications", group = "notifications" }),
  awful.key({ "Control" }, "`", function()
    awful.spawn("dunstctl history-pop")
  end, { description = "open notification", group = "notifications" })
)

M.clientkeys = gears.table.join(
  awful.key({ modkey, "Shift" }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey }, "f", function(c)
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
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
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
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

return M
