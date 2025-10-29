return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  config = function()
    require("copilot").setup({
      server_opts_overrides = {
        offset_encoding = "utf-16", -- See `:h vim.lsp.start` for more info
      },
      copilot_model = "gpt-41-copilot",
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        keymap = {
          next = "<S-]>",
          prev = "<S-[>",
          accept = "<Tab>",
          accept_word = "<S-Tab>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    })
  end,
}
