-- TODO add more language support
-- TODO configure keymaps

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    -- "nvim-treesitter/playground",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "comment",
        "gitignore",
        "go",
        "lua",
        "markdown",
        "markdown_inline",
        "ssh_config",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        -- Bash
        -- Diff
        -- Dockerfile
        -- dot?
        -- git_config
        -- git_rebase
        -- gitcommit
        -- gitignore
        -- html
        -- http
        -- json
        -- javascript
        -- ruby
        -- make
        -- just
        -- nginx
        -- python
        -- regex
        -- sql
        -- terraform
        -- tmux
        -- toml
        -- xml
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    })
  end,
}
