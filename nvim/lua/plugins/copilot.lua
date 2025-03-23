return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()

    require("copilot").setup({
      suggestion = {
        enabled = true,
        copilot_model = "gpt-4o-copilot",
        auto_trigger = true,
        keymap = {
          next = "<S-Right>",
          prev = "<S-Left>",
        },
      },
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "CopilotSuggestion", { guifg = "#83a598", ctermfg = 12, gui = "italic", cterm = "italic" })
      end,
    })

  end,
}
