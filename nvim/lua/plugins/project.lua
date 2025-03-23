return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      patterns = { "!=gruvbox", "!=gitstatus", "!=zsh-vi-mode", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    }
  end
}
