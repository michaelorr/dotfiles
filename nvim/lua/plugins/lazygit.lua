return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = { "LazyGit" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  config = function()
    vim.g.lazygit_floating_window_use_plenary = 0
  end,
}
