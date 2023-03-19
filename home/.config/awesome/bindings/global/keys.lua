-- Global keybinds which work all the time.

-- Required modules
local awful = require("awful")

local mod = require("bindings.modifiers") -- modifier keys
local terminal = os.getenv("TERMINAL")

-- awesome
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "r",
    description = "reload awesome",
    group = "awesome",
    on_press = function()
      awesome.restart()
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "q",
    description = "quit awesome",
    group = "awesome",
    on_press = function()
      awesome.quit()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "F1",
    description = "show keybinds",
    group = "awesome",
    on_press = function()
      local beautiful = require("beautiful")
      local my_popup = require("awful.hotkeys_popup").widget.new({
        width = 1600,
        height = 900,
        labels = {
          Control = "ctrl",
          Mod1 = "alt",
          Mod4 = "super",
          Shift = "shift",
          Insert = "ins",
          Delete = "del",
          Next = "pgdn",
          Prior = "pgup",
          Print = "print",
          Left = "←",
          Up = "↑",
          Right = "→",
          Down = "↓",
          KP_End = "Num1",
          KP_Down = "Num2",
          KP_Next = "Num3",
          KP_Left = "Num4",
          KP_Begin = "Num5",
          KP_Right = "Num6",
          KP_Home = "Num7",
          KP_Up = "Num8",
          KP_Prior = "Num9",
          KP_Insert = "Num0",
          KP_Delete = "Num.",
          KP_Divide = "Num/",
          KP_Multiply = "Num*",
          KP_Subtract = "Num-",
          KP_Add = "Num+",
          KP_Enter = "NumEnter",
          -- Some "obvious" entries are necessary for the Escape sequence
          -- and whitespace characters:
          Escape = "esc",
          Tab = "tab",
          space = "space",
          Return = "enter",
          -- Dead keys aren't distinct from non-dead keys because no sane
          -- layout should have both of the same kind:
          dead_acute = "´",
          dead_circumflex = "^",
          dead_grave = "`",
          -- Basic multimedia keys:
          XF86MonBrightnessUp = "󰍹 +",
          XF86MonBrightnessDown = "󰍹 -",
          XF86AudioRaiseVolume = "󰝝 ",
          XF86AudioLowerVolume = "󰝞 ",
          XF86AudioMute = "󰝟 ",
          XF86AudioPlay = "⏯",
          XF86AudioPrev = "⏮",
          XF86AudioNext = "⏭",
          XF86AudioStop = "⏹",
        },
      })
      -- FIX theme.hotkeys_label_bg does not work, need to do it manually.
      -- https://github.com/awesomeWM/awesome/issues/3773
      my_popup:add_group_rules("applications", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("awesome", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("background processes", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("brightness", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("client", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("layout", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("notifications", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("screen", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("tag", { color = beautiful.hotkeys_modifiers_fg })
      my_popup:add_group_rules("volume", { color = beautiful.hotkeys_modifiers_fg })

      my_popup:show_help()
    end,
  }),
})

-- tags
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super },
    key = "Left",
    description = "view previous",
    group = "tag",
    on_press = function()
      awful.tag.viewprev()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "Right",
    description = "view next",
    group = "tag",
    on_press = function()
      awful.tag.viewnext()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "Escape",
    description = "go back",
    group = "tag",
    on_press = function()
      awful.tag.history.restore()
    end,
  }),
})

-- focus
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super },
    key = "j",
    description = "focus next by index",
    group = "client",
    on_press = function()
      awful.client.focus.byidx(1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "k",
    description = "focus previous by index",
    group = "client",
    on_press = function()
      awful.client.focus.byidx(-1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "]",
    description = "focus next screen",
    group = "screen",
    on_press = function()
      awful.screen.focus_relative(1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "[",
    description = "focus previous screen",
    group = "screen",
    on_press = function()
      awful.screen.focus_relative(-1)
    end,
  }),
})

-- layout manipulation
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "j",
    description = "swap with next client by index",
    group = "client",
    on_press = function()
      awful.client.swap.byidx(1)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "k",
    description = "swap with previous client by index",
    group = "client",
    on_press = function()
      awful.client.swap.byidx(-1)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "u",
    description = "jump to urgent client",
    group = "client",
    on_press = function()
      awful.client.urgent.jumpto()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "l",
    description = "increase master width factor",
    group = "layout",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "h",
    description = "decrease master width factor",
    group = "layout",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
  }),
})

-- launch applications
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super },
    key = "Return",
    description = "terminal",
    group = "applications",
    on_press = function()
      awful.spawn(terminal)
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "Return",
    description = "rofi",
    group = "applications",
    on_press = function()
      awful.spawn("rofi -show run")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "b",
    description = "browser",
    group = "applications",
    on_press = function()
      awful.spawn(os.getenv("BROWSER"))
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "i",
    description = "htop",
    group = "applications",
    on_press = function()
      awful.spawn(terminal .. " start htop")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "m",
    description = "mail",
    group = "applications",
    on_press = function()
      awful.spawn(terminal .. " start neomutt")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "n",
    description = "newsboat",
    group = "applications",
    on_press = function()
      awful.spawn(terminal .. " start newsboat")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "p",
    description = "pass",
    group = "applications",
    on_press = function()
      awful.spawn("rofi-pass")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "s",
    description = "steam",
    group = "applications",
    on_press = function()
      awful.spawn("steam")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "v",
    description = "editor",
    group = "applications",
    on_press = function()
      awful.spawn(terminal .. " start " .. os.getenv("EDITOR"))
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "x",
    description = "xournalpp",
    group = "applications",
    on_press = function()
      awful.spawn("xournalpp")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "Print",
    description = "flameshot",
    group = "applications",
    on_press = function()
      awful.spawn("flameshot gui")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "F12",
    description = "lock screen",
    group = "applications",
    on_press = function()
      awful.spawn("i3lock --color=282a36 -u")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "z",
    description = "change keyboard layout",
    group = "applications",
    on_press = function()
      awful.spawn("kblayout")
    end,
  }),
})

-- volume control
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = {},
    key = "XF86AudioMute",
    description = "(un)mute audio",
    group = "volume",
    on_press = function()
      awful.spawn("wpctl set-mute @DEFAULT_SINK@ toggle")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioLowerVolume",
    description = "lower volume",
    group = "volume",
    on_press = function()
      awful.spawn("wpctl set-volume @DEFAULT_SINK@ 5%-")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioRaiseVolume",
    description = "raise volume",
    group = "volume",
    on_press = function()
      awful.spawn("wpctl set-volume @DEFAULT_SINK@ 5%+")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "/",
    description = "(un)mute mic",
    group = "volume",
    on_press = function()
      awful.spawn("micmute")
    end,
  }),
})

-- brightness control
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessDown",
    on_press = function()
      awful.spawn("xbacklight -dec 10")
    end,
    description = "lower brightness",
    group = "brightness",
  }),
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessUp",
    description = "raise brightness",
    group = "brightness",
    on_press = function()
      awful.spawn("xbacklight -inc 10")
    end,
  }),
})

-- background processes
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "r",
    description = "reload gpg agent",
    group = "background processes",
    on_press = function()
      awful.spawn("gpg-connect-agent reloadagent /bye")
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "s",
    on_press = function()
      awful.spawn("backgroundstart")
    end,
    description = "start background processes",
    group = "background processes",
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "q",
    on_press = function()
      awful.spawn("backgroundstop")
    end,
    description = "stop background processes",
    group = "background processes",
  }),
})

-- notifications
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "d",
    description = "close notification",
    group = "notifications",
    on_press = function()
      awful.spawn("dunstctl close")
    end,
  }),
  awful.key({
    modifiers = { mod.ctrl, mod.super },
    key = "d",
    description = "close all notifications",
    group = "notifications",
    on_press = function()
      awful.spawn("dunstctl close-all")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "d",
    description = "open notification",
    group = "notifications",
    on_press = function()
      awful.spawn("dunstctl history-pop")
    end,
  }),
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
