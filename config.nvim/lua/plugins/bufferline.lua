local bufferline = require("bufferline")

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>bb",
      function()
        bufferline.pick()
      end,
      desc = "Choose a buffer",
    },
  },
  opts = {
    options = {
      right_mouse_command = "vertical sbuffer %d",
      indicator = {
        style = "none",
      },
      separator_style = { "▕", "▕" },
    },
  },
}
