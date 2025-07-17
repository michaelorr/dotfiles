-- Commands:
-- :Gitsigns blame
-- :Gitsigns blame_line

-- Normal mode:
-- <leader>gb - Open Blame window

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup({
      signcolumn = true,
      numhl      = true,

      word_diff  = false,
      linehl     = false,
    })
    vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { noremap = true, silent = true })
  end,
}
