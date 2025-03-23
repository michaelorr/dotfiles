return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "j-hui/fidget.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
      cmd = {
        adapter = "copilot",
      },
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      copilot = function()
        return require("codecompanion.adapters").extend("copilot")
      end,
    },
  },
}
