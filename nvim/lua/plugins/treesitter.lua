-- TODO add more language support
-- TODO configure keymaps

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground",
    },
    config = function()
      local aug = vim.api.nvim_create_augroup("treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = aug,
        pattern = {
          "c", "gitconfig", "go", "gotmpl", "helm", "javascript", "json",
          "lua", "make", "markdown", "proto", "python", "query", "rust",
          "sql", "terraform", "toml", "yaml",
        },
        callback = function()
          vim.cmd [[setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()]]
        end,
      })

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "comment",
          "cpp",
          "diff",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gosum",
          "gotmpl",
          "gowork",
          "graphql",
          "helm",
          "html",
          "http",
          "java",
          "javascript",
          "json",
          "just",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "proto",
          "python",
          "query",
          "regex",
          "rust",
          "ruby",
          "ssh_config",
          "strace",
          "sql",
          "terraform",
          "tmux",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
        textobjects = {
          enable = true,
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
}
