return {
  "LintaoAmons/cd-project.nvim",
  config = function()
    require("cd-project").setup {
      patterns = { "!=gruvbox", "!=gitstatus", "!=zsh-vi-mode", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

      projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
      project_dir_pattern = { "!=gruvbox", "!=gitstatus", "!=zsh-vi-mode", ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
      choice_format = "both",        -- optional, you can switch to "name" or "path"
      projects_picker = "telescope", -- optional, you can switch to `telescope`
      auto_register_project = false, -- optional, toggle on/off the auto add project behaviour
      hooks = {
        {
          trigger_point = "AFTER_CD",
          callback = function(_)
            vim.cmd("Telescope git_files")
          end
        },
      }
    }
  end
}
