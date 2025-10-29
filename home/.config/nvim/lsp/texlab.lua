-- https://github.com/latex-lsp/texlab

return {
  cmd = { "texlab" },
  filetypes = {
    "bib",
    "tex",
  },
  root_markers = {
    ".git",
    ".latexmkrc",
    "latexmkrc",
    ".texlabroot",
    "texlabroot",
  },
  settings = {
    texlab = {
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
      },
    },
  },
}
