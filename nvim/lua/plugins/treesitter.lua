return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "vim",
        "ruby",
        "go",
        "comment",
        -- Consider adding:
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
        -- make
        -- just
        -- nginx
        -- python
        -- regex
        -- sql
        -- terraform
        -- xml
      },
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
