-- Keep the focus on the active window while it opens a window.
-- E.g. Neovim opening a LaTeX PDF preview.

function _G.keep_focus()
  local window = hl.get_active_window()

  local subscription
  subscription = hl.on("window.open", function()
    hl.dispatch(hl.dsp.focus({ window = window }))
    subscription:remove()
  end)

  -- Give up if no window opens, e.g. on a forward search in an open viewer
  hl.timer(function()
    subscription:remove()
  end, { timeout = 3000, type = "oneshot" })
end
