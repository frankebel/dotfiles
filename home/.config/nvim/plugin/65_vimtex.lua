-- Filetype and syntax plugin for LaTeX.

vim.pack.add({
  {
    src = "https://github.com/lervag/vimtex",
    version = "v2.18",
  },
})

vim.g.vimtex_view_method = "zathura_simple" -- no `xdotool` on Wayland
vim.g.vimtex_view_automatic = 0
vim.g.vimtex_toc_config = {
  hide_line_numbers = 0,
  layer_status = {
    content = 1,
    label = 0,
    todo = 0,
    include = 0,
  },
}

-- Custom keymaps in `after/ftplugin/tex.lua`.
-- See `:help vimtex-default-mappings`
vim.g.vimtex_mappings_enabled = 0
