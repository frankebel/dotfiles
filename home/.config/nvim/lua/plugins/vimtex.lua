-- Filetype and syntax plugin for LaTeX.
-- https://github.com/lervag/vimtex

return {
  "lervag/vimtex",
  version = "*",
  lazy = false, -- not recommended to lazy load
  init = function()
    vim.g.vimtex_view_method = "zathura_simple" -- no `xdotool` on Wayland
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "build",
      out_dir = "",
    }
  end,
}
