-- Global keybindings which work all the time.
-- TODO group keybinds

-- Required modules
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local mod = require("bindings.modifiers") -- modifier keys
local terminal = os.getenv("TERMINAL")

awful.keyboard.append_global_keybindings({
  awful.key({ mod.super }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ mod.super }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ mod.super }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ mod.super }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key({ mod.super }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ mod.super }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),

  -- Layout manipulation
  awful.key({ mod.super, mod.shift }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ mod.super, mod.shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),
  awful.key({ mod.super }, "]", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ mod.super }, "[", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  awful.key(
    { mod.super },
    "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),

  -- Standard program
  awful.key({ mod.super, mod.ctrl }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ mod.super, mod.ctrl }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ mod.super }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ mod.super }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ mod.super, mod.shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ mod.super, mod.shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ mod.super, mod.ctrl }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ mod.super, mod.ctrl }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
  awful.key({ mod.super }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ mod.super, mod.shift }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  -- Launch applications
  awful.key({ mod.super }, "Return", function()
    awful.spawn(terminal)
  end, { description = "lauch terminal", group = "applications" }),
  awful.key({ mod.super, mod.shift }, "Return", function()
    awful.spawn("rofi -show run")
  end, { description = "launch rofi", group = "applications" }),
  awful.key({ mod.super }, "b", function()
    awful.spawn(os.getenv("BROWSER"))
  end, { description = "launch browser", group = "applications" }),
  awful.key({ mod.super }, "i", function()
    awful.spawn(terminal .. " start htop")
  end, { description = "launch htop", group = "applications" }),
  awful.key({ mod.super }, "m", function()
    awful.spawn(terminal .. " start neomutt")
  end, { description = "launch mail", group = "applications" }),
  awful.key({ mod.super }, "n", function()
    awful.spawn(terminal .. " start newsboat")
  end, { description = "launch newsboat", group = "applications" }),
  awful.key({ mod.super }, "p", function()
    awful.spawn("rofi-pass")
  end, { description = "launch pass", group = "applications" }),
  awful.key({ mod.super }, "s", function()
    awful.spawn("steam")
  end, { description = "launch steam", group = "applications" }),
  awful.key({ mod.super }, "v", function()
    awful.spawn(terminal .. " start " .. os.getenv("EDITOR"))
  end, { description = "launch editor", group = "applications" }),
  awful.key({ mod.super }, "x", function()
    awful.spawn("xournalpp")
  end, { description = "launch xournalpp", group = "applications" }),
  awful.key({}, "Print", function()
    awful.spawn("flameshot gui")
  end, { description = "launch flameshot gui", group = "applications" }),
  awful.key({ mod.super }, "F12", function()
    awful.spawn("i3lock --color=282a36 -u")
  end, { description = "lock screen", group = "applications" }),
  awful.key({ mod.super }, "z", function()
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
  awful.key({ mod.super }, "/", function()
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
  awful.key({ mod.super, mod.shift }, "r", function()
    awful.spawn("gpg-connect-agent reloadagent /bye")
  end, { description = "reload gpg agent", group = "background processes" }),
  awful.key({ mod.super, mod.shift }, "s", function()
    awful.spawn("backgroundstart")
  end, { description = "start background processes", group = "background processes" }),
  awful.key({ mod.super, mod.shift }, "q", function()
    awful.spawn("backgroundstop")
  end, { description = "stop background processes", group = "background processes" }),

  -- Notifications
  awful.key({ mod.ctrl }, "space", function()
    awful.spawn("dunstctl close")
  end, { description = "close notification", group = "notifications" }),
  awful.key({ mod.ctrl, mod.shift }, "space", function()
    awful.spawn("dunstctl close-all")
  end, { description = "close all notifications", group = "notifications" }),
  awful.key({ mod.ctrl }, "`", function()
    awful.spawn("dunstctl history-pop")
  end, { description = "open notification", group = "notifications" }),
})

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super },
    keygroup = "numrow",
    description = "view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl, mod.shift },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey },
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }),
})
