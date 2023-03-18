-- Keymaps

-- Required modules
local awful = require("awful")
local gears = require("gears")

local mod = require("bindings.modifiers") -- modifier keys

local M = {}

M.clientkeys = gears.table.join(
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

M.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ mod.super }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ mod.super }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

return M
