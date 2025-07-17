-- Normal mode:
-- <leader>gg - LazyGit
-- <leader>lg - LazyGit

return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = { "LazyGit" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_use_plenary = 1
  end,
}
