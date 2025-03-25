return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = {},
  keys = {

    -- yank git link
    { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },

    -- open git link
    { "<leader>gh", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },

  },
}
