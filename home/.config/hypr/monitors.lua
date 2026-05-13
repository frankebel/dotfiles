-- https://wiki.hypr.land/Configuring/Basics/Monitors/

local hostname = require("helper").hostname

if hostname == "fdesktop" then
  hl.monitor({
    output = "DP-1",
    mode = "preferred",
    position = "2560x0",
    scale = 1,
  })
  hl.monitor({
    output = "DP-2",
    mode = "preferred",
    position = "0x0",
    scale = 1,
  })
elseif hostname == "flaptop" then
  hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    scale = 1,
  })
elseif hostname == "ftuw" then
  hl.monitor({
    output = "DP-1",
    mode = "preferred",
    position = "0x0",
    scale = 1,
  })
  hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "2560x0",
    scale = 1,
  })
end
