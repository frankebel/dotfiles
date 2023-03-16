-- Configuration for awesome window manager.
-- Website: https://awesomewm.org/
-- Docs: https://awesomewm.org/apidoc

-- Awesome library
require("awful.autofocus") -- focus after closing window

-- user files
require("handling") -- Error handling
require("themes") -- Load custom theme
require("layouts") -- List of layouts

-- Set keymaps
local keys = require("keys")
root.keys(keys.globalkeys)

require("wibar") -- statubar
require("rules") -- window rules
require("signals") -- signals for window clients
