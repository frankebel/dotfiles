-- Completion engine.
-- https://github.com/Saghen/blink.cmp
-- https://github.com/rafamadriz/friendly-snippets

return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = {
    {
      "saghen/blink.compat",
      version = "*",
      lazy = true,
      opts = {},
    },
    "kdheepak/cmp-latex-symbols",
    "rafamadriz/friendly-snippets",
  },
  opts = {
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
        "latex_symbols",
      },
      providers = {
        -- custom providers
        latex_symbols = {
          name = "latex_symbols",
          module = "blink.compat.source",
        },
      },
    },
  },
}
