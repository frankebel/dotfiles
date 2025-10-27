-- Keymaps
vim.keymap.set("n", "<leader>x", "<cmd>!python %<cr>", { desc = "Run current file" })

require("dap-python").setup("uv")
