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
      map("n", "]g", gs.next_hunk, "GITSIGNS next hunk")
      map("n", "[g", gs.prev_hunk, "GITSIGNS prev hunk")
      map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "GITSIGNS reset hunk")
      map("n", "<leader>ghp", gs.preview_hunk, "GITSIGNS Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "GITSIGNS blame line")
      map("n", "<leader>ghd", gs.diffthis, "GITSIGNS diff this")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "GITSIGNS diff this ~")
      -- stylua: ignore end
    end,
  },
}
