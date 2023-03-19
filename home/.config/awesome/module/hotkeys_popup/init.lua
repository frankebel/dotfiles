-- Custom hotkeys_popup widget
-- Docs: https://awesomewm.org/apidoc/popups_and_bars/awful.hotkeys_popup.widget.html

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

return my_popup
