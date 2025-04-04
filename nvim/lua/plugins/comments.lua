-- Mappings:
-- gcc        - toggle comment on current line
-- gc         - toggle comment on visual selection
-- gc{motion} - toggle comment on motion
  -- gcip     - toggle comment on paragraph
  -- gc4j     - toggle comment on next 4 lines
-- dic        - delete comment block

return {
  {
    'terrortylor/nvim-comment',
    event = "VeryLazy",
    config = function()
      require("nvim_comment").setup({
        comment_empty = false,
      })
    end
  }
}
