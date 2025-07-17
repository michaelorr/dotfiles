return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neotree"
  ---@type neotree.Config?
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            ".DS_Store",
            "thumbs.db",
            ".git",
            ".gitignore",
            "vendor",
            "node_modules",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>[", "<cmd>Neotree show reveal toggle<cr>", { desc = "Toggle NeoTree" })
  end,
}
