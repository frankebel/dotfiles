-- Run `fn`, which may open a window, and keep the focus on Neovim's window.
-- See `keep_focus` in the Hyprland config.
return function(fn)
  if vim.env.HYPRLAND_INSTANCE_SIGNATURE then
    vim.system({ "hyprctl", "eval", "keep_focus()" }):wait()
  end
  fn()
end
