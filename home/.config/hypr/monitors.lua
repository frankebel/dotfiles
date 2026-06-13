-- https://wiki.hypr.land/Configuring/Basics/Monitors/

local hostname = require("helper").hostname

if hostname == "fdesktop" then
  hl.monitor({
    output = "DP-2",
    mode = "preferred",
    position = "0x0",
    scale = 1,
  })
  hl.monitor({
    output = "DP-1",
    mode = "3840x2160@240",
    position = "2560x0",
    scale = 1.2,
    bitdepth = 10,
    cm = "hdr",
    vrr = 1,
    supports_hdr = 1,
    supports_wide_color = 1,
    -- drm_info | grep luminance
    min_luminance = 0.0001, -- needs to be ϵ > 0
    max_luminance = 1037,
    sdr_min_luminance = 0.0001,
    sdr_max_luminance = 120,
  })
  hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "5760x0", -- 2560 + 3840/1.2 (scaling)
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
