-- Client keybindings. Only works on focused client.

-- Required modules
local awful = require("awful")

local mod = require("bindings.modifiers") -- modifier keys

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
