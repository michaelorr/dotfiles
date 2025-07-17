-- Commands:
-- :AerialToggle!
-- :{count}AerialNext
-- :{count}AerialPrev

-- Normal mode:
-- <Leader>a     AerialToggle!
-- <Leader>{     AerialPrev
-- <Leader>}     AerialNext

-- Keymaps when Aerial is open:
--    ?      = show_help
--    <CR>   = jump
--    p      = scroll to symbol under cursor
--    {      = prev
--    }      = next
--    q      = close
--    za     = tree_toggle
--    zo     = tree_open
--    zc     = tree_close
--    zr     = tree_increase_fold_level
--    zR     = tree_open_all
--    zm     = tree_decrease_fold_level
--    zM     = tree_close_all
--    zx     = tree_sync_folds

return {
  'stevearc/aerial.nvim',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local aerial = require("aerial")
    aerial.setup({
      backends = { "lsp", "treesitter" },
      lazy_load = true,
      show_guides = true,
      layout = {
        max_width = { 60, 0.26 }, -- the lesser of 60 columns or 30% of total
        min_width = 25,
      },
      open_automatic = function(bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 60
            and aerial.num_symbols(bufnr) > 2
            and not aerial.was_closed()
      end,
      close_automatic_events = { unsupported = true },
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })
    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    vim.keymap.set("n", "<leader>]", "<cmd>AerialToggle!<CR>")
  end,
}
