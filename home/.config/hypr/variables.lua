-- https://wiki.hypr.land/Configuring/Basics/Variables/

local colors = require("mocha")
local hostname = require("helper").hostname

hl.config({
  general = {
    border_size = 2,
    gaps_in = 0,
    gaps_out = 0,
    col = {
      inactive_border = colors.base,
      active_border = colors.blue,
    },
    layout = "master",
  },

  animations = {
    enabled = false,
  },

  input = {
    kb_layout = "us",
    kb_variant = "altgr-intl",
    kb_options = "grp:alt_shift_toggle",
    resolve_binds_by_sym = 1,
    repeat_rate = 50,
    repeat_delay = 250,
    sensitivity = -0.3,
    accel_profile = "flat",
    follow_mouse = 2,
    touchpad = {
      scroll_factor = 0.2,
    },
  },

  group = {
    col = {
      border_active = colors.blue,
      border_inactive = colors.base,
    },
    groupbar = {
      font_size = 12,
      gradients = false,
      text_color = colors.text,
      col = {
        active = colors.blue,
        inactive = colors.base,
      },
    },
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 1,
    enable_swallow = true,
    swallow_regex = "^(kitty)$",
    background_color = "rgb(000000)",
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})

hl.device({
  name = "splitkb.com-aurora-corne-rev1",
  kb_layout = "us",
  kb_variant = "altgr-intl",
})

-- laptop touchpad
hl.device({
  name = "synps/2-synaptics-touchpad",
  sensitivity = 0.8,
})

-- laptop keyboard
if hostname == "flaptop" then
  hl.config({
    input = {
      kb_layout = "us,de",
      kb_variant = "colemak,",
    },
  })
end
