return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "actionlint" },
      },
      linters = {
        actionlint = {
          -- if you pass to actionlint via stdin, it will not pick up custom config file
          stdin = false,
          args = { "-format", "{{json .}}" },
        },
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/.markdownlint.yaml"), "--" },
        },
      },
    },
  },
}
