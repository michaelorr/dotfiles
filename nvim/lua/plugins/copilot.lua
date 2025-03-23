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
  end,
}
