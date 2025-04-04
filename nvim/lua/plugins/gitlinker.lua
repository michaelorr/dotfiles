-- Commands:
-- `:GitLink`                  yank the /blob url
-- `:GitLink blame`            yank the /blame url
-- `:GitLink default_branch`   yank the /main or /master url
-- `:GitLink current_branch`   yank the current branch url

-- `:GitLink!`                 open the /blob url
-- `:GitLink blame!`           open the /blame url
-- `:GitLink default_branch!`  open the /main or /master url
-- `:GitLink current_branch!`  open the current branch url

-- Normal mode:
-- <leader>gy - Yank git link
-- <leader>gh - Open git link

return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = {},
  keys = {
    { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
    { "<leader>gh", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
  },
}
