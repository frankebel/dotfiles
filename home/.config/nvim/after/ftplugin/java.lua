-- Set up nvim-jdtls
-- See https://github.com/mfussenegger/nvim-jdtls


local jdtls = require "jdtls"
local lsp_user_conf = require "user.lsp"
local home = os.getenv("HOME")
local masondir = home .. "/.local/share/nvim/mason"
local workspace_dir = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")


-- Debugger (via nvim-dap)
local bundles = {
  vim.fn.glob(masondir .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(masondir .. "/packages/java-test/extension/server/*.jar"), "\n"))
local extendedClientCapabilities = jdtls.extendedClientCapabilities


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(masondir .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", masondir .. "/packages/jdtls/config_linux",
    "-data", workspace_dir
  },
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  root_dir = require "jdtls.setup".find_root({ ".git", "mvnw", "gradlew" }),
  capabilities = lsp_user_conf.capabilities,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities
  },
  -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-setup
  on_attach = lsp_user_conf.on_attach
}


-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
