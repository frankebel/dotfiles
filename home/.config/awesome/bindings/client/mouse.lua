-- Client mousebindings. Only works on focused client.

-- Required modules
local awful = require("awful")

local mod = require("bindings.modifiers") -- modifier keys

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
