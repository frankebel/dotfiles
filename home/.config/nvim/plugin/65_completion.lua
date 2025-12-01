-- Completion engine.

vim.pack.add({
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = vim.version.range("*"),
  },
  {
    src = "https://github.com/erooke/blink-cmp-latex",
  },
})

require("blink-cmp").setup({
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
      window = {
        border = "single",
      },
    },
    ghost_text = {
      enabled = true,
    },
    list = {
      selection = {
        auto_insert = false,
      },
    },
  },
  keymap = {
    preset = "default",
  },
  signature = {
    enabled = true,
    window = {
      border = "single",
    },
  },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      "latex",
    },
    providers = {
      latex = {
        name = "Latex",
        module = "blink-cmp-latex",
        opts = {
          insert_command = function(ctx)
            local ft = vim.api.nvim_get_option_value("filetype", {
              scope = "local",
              buf = ctx.bufnr,
            })
            if ft == "tex" then
              return true
            end
            return false
          end,
        },
      },
    },
  },
})
