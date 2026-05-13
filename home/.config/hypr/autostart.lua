-- https://wiki.hypr.land/Configuring/Basics/Autostart/

local hostname = require("helper").hostname

hl.on("hyprland.start", function()
  -- Compositor-independent
  hl.exec_cmd("udiskie")
  hl.exec_cmd("lxsession")

  -- Window manager specific
  hl.exec_cmd("hypridle")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("waybar")

  -- Screen sharing
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  hl.exec_cmd('gsettings set org.gnome.desktop.interface font-name "Noto Sans Mono 12"')

  -- device-specific
  if hostname == "fdesktop" then
    hl.exec_cmd("sleep 1 && qbittorrent") -- without wait starts maximized
  end

  -- terminal emulator
  hl.exec_cmd("kitty")
  hl.exec_cmd("sleep 0.01 && hyprctl eval 'hl.dispatch(hl.dsp.focus({ workspace = 1 }))'")
end)
