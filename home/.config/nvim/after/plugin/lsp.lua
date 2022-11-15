-- LSP configuration
-- https://github.com/neovim/nvim-lspconfig

local lspconfig = require "lspconfig"

-- Configuration for mason
-- https://github.com/williamboman/mason.nvim
require "mason".setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

-- Configuration for mason-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim
require "mason-lspconfig".setup {
  ensure_installed = {
    "pyright",
    "sumneko_lua",
  }
}

-- Autocompletion
local capabilities = require "cmp_nvim_lsp".default_capabilities()

-- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition, "Go to definition")
  nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
  nmap("gT", vim.lsp.buf.type_definition, "Type definition")

  nmap("<space>rn", vim.lsp.buf.rename, "Rename")
  nmap("<space>ca", vim.lsp.buf.code_action, "Code action")

  nmap("K", vim.lsp.buf.hover, "Hover documentation")
  nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

  nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
  nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")
  nmap("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "Workspace list folders")

  nmap("gr", vim.lsp.buf.references, "List references")
  nmap("<space>f", function() vim.lsp.buf.format { async = true } end, "Format current buffer")
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Python
lspconfig["pyright"].setup {
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- Lua
lspconfig["sumneko_lua"].setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "awesome",
          "vim",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}
