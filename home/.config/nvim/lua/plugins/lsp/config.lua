-- Configuration for LSP
-- See https://github.com/neovim/nvim-lspconfig

local M = {}
local group = vim.api.nvim_create_augroup("LspFromatting", { clear = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  local function nmap(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  local function vmap(keys, func, desc)
    vim.keymap.set("v", keys, func, { buffer = bufnr, desc = desc })
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

  -- Prepend lsp keymaps with "<leader>l"
  -- stylua: ignore
  nmap("<leader>lf", function() vim.lsp.buf.format { async = true } end, "Format current buffer")

  if client.name == "jdtls" then
    -- See https://github.com/mfussenegger/nvim-jdtls
    local jdtls = require("jdtls")
    -- Additional mappings
    nmap("<A-o>", jdtls.organize_imports, "Organize imports")
    nmap("crv", jdtls.extract_variable, "Extract variable")
    nmap("crc", jdtls.extract_constant, "Extract constant")
    vmap("crv", [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]], "Extract variable")
    vmap("crc", [[<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]], "Extract constant")
    vmap("crm", [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], "Extract method")
    nmap("<leader>df", jdtls.test_class, "Test class")
    nmap("<leader>dn", jdtls.test_nearest_method, "Test method")

    -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
    -- you make during a debug session immediately.
    -- Remove the option if you do not want that.
    -- You can use the `JdtHotcodeReplace` command to trigger it manually
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

M.lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Autocompletion
-- See https://github.com/hrsh7th/cmp-nvim-lsp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
