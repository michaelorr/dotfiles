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
    vim.keymap.set("n", "<leader>p", "<cmd>CdProject<cr>", { desc = "Change Directory to Project" })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        for _, proj in ipairs(require("cd-project.api").get_project_paths()) do
          if vim.fs.relpath(proj, vim.fn.getcwd()) ~= nil then
            print("Changing directory to: " .. proj)
            vim.fn.execute("cd " .. proj)
            break
          end
        end
      end
    })
  end
}
