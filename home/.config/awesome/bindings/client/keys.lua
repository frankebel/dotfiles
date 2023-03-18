-- Client keybindings. Only works on focused client.

-- Required modules
local awful = require("awful")
local gears = require("gears")

local mod = require("bindings.modifiers") -- modifier keys

local M = gears.table.join(
  awful.key({ mod.super, mod.shift }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ mod.super }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { mod.super, mod.ctrl },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ mod.super, mod.ctrl }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ mod.super }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ mod.super }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ mod.super }, "f", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" })
)

return M
