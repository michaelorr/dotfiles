-- Commands:
--     :{count}Wrap       Wrap lines at word break (default 100 chars)
--     :WrapToggle        Toggle linewrap and linebreak
--
-- Normal mode:
--     <Leader>o          Open all files from quickfix and close quickfix
--     <Leader>p          Paste without overwriting the clipboard
--     <Leader>ws         Delete trailing whitespace
--     <Leader>ftnl       Convert newline chars
--     <Leader>q          Toggle quickfix window
--     <F10>              Show Highlight Groups under the cursor
--     <S-Up>             Move between windows
--     <S-Down>           Move between windows
--     <S-Left>           Move between windows
--     <S-Right>          Move between windows
--
-- Visual mode:
--     <S-Up>             Expand existing selection up
--     <S-Down>           Expand existing selection down
--
-- Insert mode:
--     <S-Up>             <nop>
--     <S-Down>           <nop>
--     <C-\>              Delete previous word from cursor position

-- Set leaders first so mappings are correct
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Init lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  install = { colorscheme = { 'gruvbox' } },
  spec = { { import = "plugins" } },
  checker = { enabled = true },
  rocks = { hererocks = false },
})

-- All other configs
require('config')
