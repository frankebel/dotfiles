-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- awesome libraries
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")
local ruled = require("ruled")
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
-- Create base template for wibar widgets.
local function create_wibar_widget(widget, color_fg)
  return wibox.widget({
    {
      {
        widget = widget,
      },
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin,
    },
    shape = gears.shape.rounded_bar,
    bg = beautiful.widget_bg,
    fg = color_fg,
    widget = wibox.container.background,
  })
end

-- Set path for custom widgets.
local widgets_path = "~/.local/bin/statusbar/"

-- Create a separator widget
local mysep = wibox.widget.separator({
  orientation = "vertical",
  span_ratio = 0.9,
  forced_width = 10,
})

-- Create a battery widget
local battery_text = awful.widget.watch(gears.filesystem.get_configuration_dir() .. "scripts/battery.sh", 10)

-- Create a mail widget
local mail_text = awful.widget.watch(gears.filesystem.get_configuration_dir() .. "scripts/mail.sh", 60)

-- Create a microphone widget
local microphone_text, microphone_timer =
  awful.widget.watch(gears.filesystem.get_configuration_dir() .. "scripts/microphone.sh", 60)

-- Create a volume widget
local volume_text, volume_timer =
  awful.widget.watch(gears.filesystem.get_configuration_dir() .. "scripts/volume.sh", 60)

-- Create a clock widget
local clock_text = wibox.widget.textclock(" %T", 1)

-- Create a date widget
local date_text = wibox.widget.textclock(" %F (%a)", 3600)

-- Right widgets
local widgets_right = {
  wibox.widget.systray(),
  create_wibar_widget(battery_text, beautiful.widget_fg6),
  create_wibar_widget(mail_text, beautiful.widget_fg5),
  create_wibar_widget(microphone_text, beautiful.widget_fg4),
  create_wibar_widget(volume_text, beautiful.widget_fg3),
  create_wibar_widget(date_text, beautiful.widget_fg1),
  create_wibar_widget(clock_text, beautiful.widget_fg2),
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

-- Key bindings
-- General Awesome keys
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
      local my_popup = require("awful.hotkeys_popup").widget.new({
        width = dpi(1600),
        height = dpi(900),
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

-- Tags related keybindings
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

-- Focus related keybindings
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

-- Layout related keybindings
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

-- Launch applications
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
    modifiers = { mod.super },
    key = "y",
    description = "play clipboard in mpv",
    group = "applications",
    on_press = function()
      awful.spawn.with_shell('mpv "$(xclip -selection c -out)"')
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
})

-- Volume control related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = {},
    key = "XF86AudioMute",
    description = "(un)mute audio",
    group = "volume",
    on_press = function()
      awful.spawn.with_line_callback("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", {
        exit = function()
          volume_timer:emit_signal("timeout")
        end,
      })
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioLowerVolume",
    description = "lower volume",
    group = "volume",
    on_press = function()
      awful.spawn.with_line_callback("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", {
        exit = function()
          volume_timer:emit_signal("timeout")
        end,
      })
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioRaiseVolume",
    description = "raise volume",
    group = "volume",
    on_press = function()
      awful.spawn.with_line_callback("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+", {
        exit = function()
          volume_timer:emit_signal("timeout")
        end,
      })
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "/",
    description = "(un)mute mic",
    group = "volume",
    on_press = function()
      awful.spawn.with_line_callback("micmute", {
        exit = function()
          microphone_timer:emit_signal("timeout")
        end,
      })
    end,
  }),
})

-- Brightness control related keybindings
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

-- Background processes related keybindings
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

-- Notifications related keybindings
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

-- Tage related keybindings
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
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ mod.super }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ mod.super }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({
      modifiers = { mod.super, mod.shift },
      key = "f",
      description = "toggle fullscreen",
      group = "client",
      on_press = function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
    }),
    awful.key({
      modifiers = { mod.super },
      key = "q",
      description = "close",
      group = "client",
      on_press = function(c)
        c:kill()
      end,
    }),
    awful.key({
      modifiers = { mod.super, mod.ctrl },
      key = "space",
      description = "toggle floating",
      group = "client",
      on_press = function()
        awful.client.floating.toggle()
      end,
    }),
    awful.key({
      modifiers = { mod.super, mod.ctrl },
      key = "Return",
      description = "move to master",
      group = "client",
      on_press = function(c)
        c:swap(awful.client.getmaster())
      end,
    }),
    awful.key({
      modifiers = { mod.super },
      key = "o",
      description = "move to screen",
      group = "client",
      on_press = function(c)
        c:move_to_screen()
      end,
    }),
    awful.key({
      modifiers = { mod.super },
      key = "t",
      description = "toggle keep on top",
      group = "client",
      on_press = function(c)
        c.ontop = not c.ontop
      end,
    }),
    awful.key({
      modifiers = { mod.super },
      key = "f",
      description = "(un)maximize",
      group = "client",
      on_press = function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
    }),
  })
end)

-- Rules
-- Rules to apply to new clients.
-- Use command "xprop WM_CLASS"
-- First string will be the instance, second string the class.
ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule({
    id = "gloal",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- Floating clients.
  ruled.client.append_rule({
    id = "floating",
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
  })

  -- Fullscreen clients.
  ruled.client.append_rule({
    id = "fullscreen",
    rule_any = {
      class = {
        "mpv",
      },
    },
    properties = {
      fullscreen = true,
    },
  })

  -- Games
  ruled.client.append_rule({
    id = "games",
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
  })

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- ruled.client.append_rule({
  --   rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" },
  -- })
end)

-- Notifications
ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule({
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  })
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box({ notification = n })
end)
