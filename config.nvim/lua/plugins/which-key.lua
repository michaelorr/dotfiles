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
  },
}
