-- Insert mode:
--  <S-Right>  - Next suggestion
--  <S-Left>   - Previous suggestion
--  <Tab>      - Accept suggestion
--  <S-Tab>    - Accept word suggestion
--  <Esc>      - Dismiss suggestion

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
          next        = "<S-Right>",
          prev        = "<S-Left>",
          accept      = "<Tab>",
          accept_word = "<S-Tab>",
        },
      },
    })
  end,
}
