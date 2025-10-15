-- disable treesitter highlighting as suggested by vimtex
vim.treesitter.stop()

-- https://github.com/folke/snacks.nvim/discussions/2080
vim.schedule(function()
  local image_doc = require("snacks.image.doc")
  local attach = image_doc.attach
  image_doc.attach = function(buf)
    if vim.bo[buf].ft:match("tex") then
      return
    end
    attach(buf)
  end
end)
