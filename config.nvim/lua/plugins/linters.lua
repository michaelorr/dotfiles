vim.filetype.add({
  pattern = {
    ["%.github/workflows/.*%.yml"] = "yaml.ghaction",
    ["%.github/workflows/.*%.yaml"] = "yaml.ghaction",
  },
})

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["yaml.ghaction"] = { "actionlint" },
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
