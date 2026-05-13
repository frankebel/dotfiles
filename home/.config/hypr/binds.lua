-- File containing key- and mousebinds
-- https://wiki.hypr.land/Configuring/Binds/
-- https://wiki.hypr.land/Configuring/Dispatchers/

-- Quit hyprland
hl.bind("SUPER + CTRL + Q", hl.dsp.exit())

-- Focus between monitors
hl.bind("SUPER + p", hl.dsp.focus({ monitor = "-1" }))
hl.bind("SUPER + n", hl.dsp.focus({ monitor = "+1" }))

-- Move active window between monitors
hl.bind("SUPER + SHIFT + p", hl.dsp.window.move({ monitor = "-1" }))
hl.bind("SUPER + SHIFT + n", hl.dsp.window.move({ monitor = "+1" }))

-- Swap workspaces
hl.bind("SUPER + s", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "-1" }))
hl.bind("SUPER + SHIFT + s", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

-- Move between workspaces
hl.bind("SUPER + u", hl.dsp.focus({ urgent_or_last = true }))

-- Switch workspaces with SUPER + [1-9]
for i = 1, 9 do
  hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
end

-- Focus window going up/down the stack
hl.bind("SUPER + j", hl.dsp.layout("cyclenext"))
hl.bind("SUPER + k", hl.dsp.layout("cycleprev"))

-- Move window going up/down the stack
hl.bind("SUPER + SHIFT + j", hl.dsp.layout("swapnext"))
hl.bind("SUPER + SHIFT + k", hl.dsp.layout("swapprev"))

-- Move active window to a workspace with SUPER + SHIFT + [1-9]
for i = 1, 9 do
  hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Focused window manipulation
hl.bind("SUPER + q", hl.dsp.window.close())
hl.bind("SUPER + f", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + SHIFT + f", hl.dsp.window.fullscreen())
hl.bind("SUPER + t", hl.dsp.window.float())
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- group
hl.bind("SUPER + g", hl.dsp.group.toggle())
hl.bind("SUPER + left", hl.dsp.group.prev())
hl.bind("SUPER + right", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + left", hl.dsp.group.move_window({ forward = false }))
hl.bind("SUPER + SHIFT + right", hl.dsp.group.move_window())

-- Launch applications
hl.bind("SUPER + return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + return", hl.dsp.exec_cmd("wofi --show run"))
hl.bind("SUPER + b", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + i", hl.dsp.exec_cmd("tessen --action autotype"))
hl.bind("SUPER + m", hl.dsp.exec_cmd("kitty -e neomutt"))
hl.bind("SUPER + r", hl.dsp.exec_cmd("kitty -e newsboat"))
hl.bind("SUPER + v", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind("SUPER + x", hl.dsp.exec_cmd("xournalpp"))
hl.bind("SUPER + z", hl.dsp.exec_cmd("zotero"))
hl.bind("Print", hl.dsp.exec_cmd("grim -g '$(slurp)' - | wl-copy"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" "$TEMPDIR/$(date +%s.png)"'))
hl.bind("SUPER + SHIFT + Print", hl.dsp.exec_cmd('grim -o DP-1 "$TEMPDIR/$(date +%s.png)"'))
hl.bind("SUPER + F12", hl.dsp.exec_cmd("hyprlock"))

-- Volume control
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && volume_indicator"))
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && volume_indicator"),
  { repeating = true }
)
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && volume_indicator"),
  { repeating = true }
)
hl.bind("SUPER + slash", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && mic_indicator"))

-- Brightness control
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-; brightness_indicator"))
hl.bind("XF86MonBrightnessUP", hl.dsp.exec_cmd("brightnessctl set 10%+; brightness_indicator"))

-- Start/stop background processes
hl.bind("SUPER + SHIFT + r", hl.dsp.exec_cmd("gpg-connect-agent reloadagent /bye"))
hl.bind("SUPER + SHIFT + c", hl.dsp.exec_cmd("backgroundstart"))
hl.bind("SUPER + SHIFT + q", hl.dsp.exec_cmd("backgroundstop"))

-- dunst control
hl.bind("SUPER + d", hl.dsp.exec_cmd("dunstctl close"), { repeating = true })
hl.bind("SUPER + SHIFT + d", hl.dsp.exec_cmd("dunstctl history-pop"), { repeating = true })
