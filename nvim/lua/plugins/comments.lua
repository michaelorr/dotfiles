-- Normal mode:
-- gcc        - toggle on current line
-- gc{motion} - toggle for motion
  -- gcic     - toggle entire comment block
  -- gcip     - toggle paragraph
  -- gc4j     - toggle next 4 lines
-- dic        - delete comment block

-- Visual mode:
-- gc         - toggle comment on visual selection

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
