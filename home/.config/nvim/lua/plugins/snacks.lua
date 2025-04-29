-- A collection of small QoL plugins for Neovim.
-- https://github.com/folke/snacks.nvim

return {
  "folke/snacks.nvim",
  version = false,
  priority = 1000,
  keys = {
    {
      "<leader>K",
      function()
        Snacks.image.hover()
      end,
      desc = "SNACKS hover image",
    },
  },
  opts = {
    image = {
      doc = {
        enabled = true,
        -- do not render automatically
        inline = false,
        float = false,
      },
    },
  },
}
