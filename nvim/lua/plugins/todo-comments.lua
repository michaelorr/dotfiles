return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
        search = { pattern = "\\b(KEYWORDS)(\\([^\\)]*\\))?[: ]" },
        highlight = {
          keyword = 'wide_bg',
          pattern = ".*<((KEYWORDS)(\\(.{-1,}\\))?)[: ]",
        },
      })
  end,
}
