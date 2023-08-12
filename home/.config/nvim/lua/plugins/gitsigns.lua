-- Git decorations.
-- https://github.com/lewis6991/gitsigns.nvim

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- stylua: ignore start
      map("n", "]g", gs.next_hunk, "gitsigns next hunk")
      map("n", "[g", gs.prev_hunk, "gitsigns prev hunk")
      map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "gitsigns reset hunk")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "gitsigns blame line")
      map("n", "<leader>ghd", gs.diffthis, "gitsigns diff this")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "gitsigns diff this ~")
      -- stylua: ignore end
    end,
  },
}
