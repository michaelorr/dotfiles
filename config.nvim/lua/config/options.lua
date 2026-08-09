-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.completeopt = "menu,menuone,noselect,longest,preview"
opt.shortmess:append({ a = true })

opt.colorcolumn = "140"

opt.timeoutlen = 600
opt.whichwrap = "<,>,h,l,[,],s,b"

opt.foldmethod = "indent"
opt.foldnestmax = 10
opt.foldlevel = 99
opt.foldcolumn = "auto:3"
opt.foldopen = vim.opt.foldopen:append("jump")

opt.diffopt = "filler,closeoff,algorithm:histogram,iwhite,linematch:90"

opt.breakindent = true

vim.g.is_bash = 1

opt.inccommand = "split"
opt.fileformats:append("mac")
opt.formatoptions:remove("o")

opt.synmaxcol = 20000

vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "standardrb"

-----------------------------------
-- Highlight Inavalid Whitespace --
-----------------------------------

-- 1. Turn on list mode for all files with a filetype
-- 2. Set the listchars (including tabs)
-- 3. For our window, link the Whitespace highlight to the WhitespaceRed highlight

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- All invalid whitespace should have a red fg
    -- |hl-NonText| will be used for "extends" and "precedes"
    -- |hl-Whitespace| for "nbsp", "space", "tab", "multispace", "lead" and "trail"
    -- (hl-Whitespace is linked to hl-InvalidWhitespace in gruvbox config)
    vim.opt_local.list = true
    vim.opt_local.listchars = "tab:> ,trail:•,extends:→,precedes:←,nbsp:␣"
  end,
})

-- 4. For these filetypes, leading tabs chars are common or valid, don't highlight them

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "just", "make", "help", "gitcommit" },
  callback = function()
    vim.opt_local.listchars = "tab:  ,trail:•,extends:→,precedes:←,nbsp:␣"
  end,
})

-- 5. Turn off list mode and don't highlight whitespace in these filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fzf", "help", "gitcommit", "TelescopePrompt", "TelescopeResults", "mason", "lazy", "diff" },
  callback = function()
    vim.opt_local.list = false
  end,
})

-- 6. Floating windows (completion menus, cmdline popup, etc.) inherit 'list' from
-- whatever window they were opened relative to, so they pick up the trailing-whitespace
-- markers too. Nvim re-copies local options into the new window right after WinNew
-- fires, silently undoing an immediate override, so the fix has to be deferred a tick.
vim.api.nvim_create_autocmd("WinNew", {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win).relative == "" then
      return
    end
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_set_option_value("list", false, { win = win })
      end
    end)
  end,
})

-- For go:
-- 5. Don't show tabs
-- 6. Link the Whitespace highlight to the GoTab highlight (instead of InvalidWhitespace)
-- 7. Apply the InvalidWhitespace highlight to trailing spaces and mixed leading indent

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.listchars = "tab:  ,trail:•,extends:→,precedes:←,nbsp:␣"
    vim.cmd("set winhighlight=Whitespace:GoTab")

    vim.fn.matchadd("InvalidWhitespace", [[^\s* \+]])
    vim.fn.matchadd("InvalidWhitespace", [[\s\+$]])
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Gemfile", "Guardfile", "VagrantFile", "*.pp" },
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- http://vi.stackexchange.com/questions/137/how-do-i-edit-crontab-files-with-vim-i-get-the-error-temp-file-must-be-edited
-- crontab must be edited 'in place'
vim.api.nvim_create_autocmd("FileType", {
  pattern = "crontab",
  command = "setlocal nobackup nowritebackup noswapfile",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*tmux.conf*",
  callback = function()
    vim.bo.filetype = "tmux"
    vim.bo.syntax = "tmux"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "Dockerfile.tmpl",
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "nginx.conf.*",
  callback = function()
    vim.bo.filetype = "nginx"
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "/usr/local/src/wistia/wistia-setup/**.sh",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.g.ai_cmp = false
