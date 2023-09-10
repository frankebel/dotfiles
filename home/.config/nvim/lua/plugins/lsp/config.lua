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

  nmap("gd", vim.lsp.buf.definition, "LSP Go to definition")
  nmap("gD", vim.lsp.buf.declaration, "LSP Go to declaration")
  nmap("gT", vim.lsp.buf.type_definition, "LSP Type definition")

  nmap("<leader>rn", vim.lsp.buf.rename, "LSP Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "LSP Code action")

  nmap("K", vim.lsp.buf.hover, "LSP Hover documentation")
  nmap("gi", vim.lsp.buf.implementation, "LSP Go to implementation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "LSP Signature documentation")

  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "LSP Workspace add folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "LSP Workspace remove folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "LSP Workspace list folders")

  nmap("gr", vim.lsp.buf.references, "LSP List references")

  -- Prepend lsp keymaps with "<leader>l"
  -- stylua: ignore
  nmap("<leader>lf", function() vim.lsp.buf.format { async = true } end, "LSP Format current buffer")

  if client.name == "jdtls" then
    -- See https://github.com/mfussenegger/nvim-jdtls
    local jdtls = require("jdtls")
    -- Additional mappings
    nmap("<A-o>", jdtls.organize_imports, "LSP Organize imports")
    nmap("crv", jdtls.extract_variable, "LSP Extract variable")
    nmap("crc", jdtls.extract_constant, "LSP Extract constant")
    vmap("crv", [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]], "LSP Extract variable")
    vmap("crc", [[<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]], "LSP Extract constant")
    vmap("crm", [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], "LSP Extract method")
    nmap("<leader>df", jdtls.test_class, "LSP Test class")
    nmap("<leader>dn", jdtls.test_nearest_method, "LSP Test method")

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
