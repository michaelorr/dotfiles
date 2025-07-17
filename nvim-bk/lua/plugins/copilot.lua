-- Insert mode:
--  <S-Right>  - Next suggestion
--  <S-Left>   - Previous suggestion
--  <Tab>      - Accept suggestion
--  <S-Tab>    - Accept word suggestion
--  <Esc>      - Dismiss suggestion

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  lazy = true,
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      copilot_model = "gpt-4o-copilot",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          next        = "<S-Right>",
          prev        = "<S-Left>",
          accept      = "<Tab>",
          accept_word = "<S-Tab>",
        },
      },
    })
  end,
}
