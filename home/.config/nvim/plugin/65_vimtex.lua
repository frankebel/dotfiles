-- Filetype and syntax plugin for LaTeX.

vim.pack.add({
  {
    src = "https://github.com/lervag/vimtex",
    version = vim.version.range("*"),
  },
})

vim.g.vimtex_view_method = "zathura_simple" -- no `xdotool` on Wayland
vim.g.vimtex_toc_config = {
  hide_line_numbers = 0,
  layer_status = {
    content = 1,
    label = 0,
    todo = 0,
    include = 0,
  },
}

-- Custom keymaps.
-- See `:help vimtex-default-mappings`
vim.g.vimtex_mappings_enabled = 0
local function map(mode, l, r, desc)
  vim.keymap.set(mode, l, r, { desc = desc })
end
-- compilation
map("n", "<localleader>tt", "<cmd>VimtexTocOpen<cr>", "VTEX open table of contents ToC")
map("n", "<localleader>tv", "<cmd>VimtexView<cr>", "VTEX view in pdf")
map("n", "<localleader>tc", "<cmd>VimtexCompile<cr>", "VTEX compile")
-- Need to start command with `:` otherwise lines are not taken
map("x", "<localleader>tC", ":VimtexCompileSelected<cr>", "VTEX compile selcted")
map("n", "<localleader>te", "<cmd>VimtexErrors<cr>", "VTEX open errors")
map("n", "<localleader>td", "<cmd>VimtexClean<cr>", "VTEX clean aux files (delete)")
map("n", "<localleader>tm", "<cmd>VimtexImapsList<cr>", "VTEX list insert mode mappings")

-- deletion
map("n", "dse", "<plug>(vimtex-env-delete)", "VTEX delete surrounding environment")
map("n", "dsc", "<plug>(vimtex-cmd-delete)", "VTEX delete surrounding command")
map("n", "ds$", "<plug>(vimtex-env-delete-math)", "VTEX delete surrounding math environment")
map("n", "dsd", "<plug>(vimtex-delim-delete)", "VTEX delete surrounding delimiter")

-- change
map("n", "cse", "<plug>(vimtex-env-change)", "VTEX change surrounding environment")
map("n", "csc", "<plug>(vimtex-cmd-change)", "VTEX change surrounding command")
map("n", "cs$", "<plug>(vimtex-env-change-math)", "VTEX change surrounding math environment")
map("n", "csd", "<plug>(vimtex-delim-change-math)", "VTEX change surrounding delimiter")

-- toggle
map("n", "tsf", "<plug>(vimtex-cmd-toggle-frac)", "VTEX toggle surrounding fraction")
map("n", "tsc", "<plug>(vimtex-cmd-toggle-star)", "VTEX toggle starred command")
map("n", "tse", "<plug>(vimtex-env-toggle-star)", "VTEX toggle starred environment")

-- textobjcets
map({ "x", "o" }, "ac", "<plug>(vimtex-ac)", "VTEX around command")
map({ "x", "o" }, "ic", "<plug>(vimtex-ic)", "VTEX inside command")
map({ "x", "o" }, "ad", "<plug>(vimtex-ad)", "VTEX around delimiter")
map({ "x", "o" }, "id", "<plug>(vimtex-id)", "VTEX inside delimiter")
map({ "x", "o" }, "ae", "<plug>(vimtex-ae)", "VTEX around environment")
map({ "x", "o" }, "ie", "<plug>(vimtex-ie)", "VTEX inside environment")
map({ "x", "o" }, "a$", "<plug>(vimtex-a$)", "VTEX around math environment")
map({ "x", "o" }, "i$", "<plug>(vimtex-i$)", "VTEX inside math environment")
map({ "x", "o" }, "as", "<plug>(vimtex-aP)", "VTEX around section")
map({ "x", "o" }, "is", "<plug>(vimtex-iP)", "VTEX inside section")

-- jump
map({ "n", "x", "o" }, "]]", "<plug>(vimtex-]])", "VTEX Jump to next section start")
map({ "n", "x", "o" }, "][", "<plug>(vimtex-][)", "VTEX Jump to next section end")
map({ "n", "x", "o" }, "[[", "<plug>(vimtex-[[)", "VTEX Jump to previous section start")
map({ "n", "x", "o" }, "[]", "<plug>(vimtex-[])", "VTEX Jump to previous section end")
map({ "n", "x", "o" }, "]e", "<plug>(vimtex-]m)", "VTEX Jump to next environment start")
map({ "n", "x", "o" }, "]E", "<plug>(vimtex-]M)", "VTEX Jump to next environment end")
map({ "n", "x", "o" }, "[e", "<plug>(vimtex-[m)", "VTEX Jump to previous environment start")
map({ "n", "x", "o" }, "[E", "<plug>(vimtex-[M)", "VTEX Jump to previous environment end")
map({ "n", "x", "o" }, "]m", "<plug>(vimtex-]n)", "VTEX Jump to next math start")
map({ "n", "x", "o" }, "]M", "<plug>(vimtex-]N)", "VTEX Jump to next math end")
map({ "n", "x", "o" }, "[m", "<plug>(vimtex-[n)", "VTEX Jump to previous math start")
map({ "n", "x", "o" }, "[M", "<plug>(vimtex-[N)", "VTEX Jump to previous math end")
map({ "n", "x", "o" }, "]r", "<plug>(vimtex-]r)", "VTEX Jump to next frame start")
map({ "n", "x", "o" }, "]R", "<plug>(vimtex-]R)", "VTEX Jump to next frame end")
map({ "n", "x", "o" }, "[r", "<plug>(vimtex-[r)", "VTEX Jump to previous frame start")
map({ "n", "x", "o" }, "[R", "<plug>(vimtex-[R)", "VTEX Jump to previous frame end")
