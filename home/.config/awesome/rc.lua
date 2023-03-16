-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- Awesome library
require("awful.autofocus") -- focus after closing window

-- Error handling
require("handling")

-- Load custom theme
require("themes")

-- List of layouts
require("layouts")

-- Set keymaps
local keys = require("keys")
root.keys(keys.globalkeys)

-- Statubar
require("wibar")

require("rules") -- window rules

require("signals")
