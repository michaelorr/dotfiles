return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    preset = "modern",
    plugins = {
      marks = false,
      spelling = {
        suggestions = 10,
      },
    },
    spec = {
      {
        -- Hide the following builtin mappings
        hidden = true,
        mode = { "n" },
        { "za", desc = "Toggle fold under cursor" },
        { "zA", desc = "Toggle all folds under cursor" },
        { "zb", desc = "Bottom this line" },
        { "zd", desc = "Delete fold under cursor" },
        { "zD", desc = "Delete all folds under cursor" },
        { "ze", desc = "Right this line" },
        { "zE", desc = "Delete all folds in file" },
        { "zf", desc = "Create fold" },
        { "zH", desc = "Half screen to the left" },
        { "zs", desc = "Left this line" },
        { "zL", desc = "Half screen to the right" },
        { "zt", desc = "Top this line" },
        { "zv", desc = "Show cursor line" },
        { "z<CR>", desc = "Top this line" },
      },
    },
  },

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
