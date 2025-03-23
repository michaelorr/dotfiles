-- Things to do:

-- Auto open Aerial for Go/Ruby/Make/Terraform/...

-- 2. formatting.lua
-- 3. lsp.lua
-- 4. mason.lua
-- 6. pulse
--
-- Theme? https://rosepinetheme.com/

-------------------
-- [[ Plugins ]] --
-------------------

-- AI Tools
-----------
-- codecompanion.nvim
-- Plug 'github/copilot.vim'
-- Plug 'github/copilot.lua'
--
-- Code Navigation/Search:
--------------------------
-- telescope-fzf-native.nvim - Fast fuzzy finder
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
-- Plug 'junegunn/fzf.vim'
--
-- Git Integration:
-------------------
-- gitsigns.nvim - Git changes in gutter
-- diffview.nvim - Better diff viewing
-- lazygit.nvim - Terminal UI for git
-- Plug 'airblade/vim-gitgutter'
-- " Open the current file or selection in github
-- noremap <Leader>gh :OpenGithubFile<CR>
-- noremap <Leader>gh :OpenGithubFile<CR>
-- Plug 'tpope/vim-rhubarb' | Plug 'tpope/vim-fugitive'
-- Plug 'tyru/open-browser-github.vim' | Plug 'tyru/open-browser.vim'
-- https://github.com/f-person/git-blame.nvim
--
-- Development Experience:
--------------------------
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-lualine/lualine.nvim
-- Plug 'vim-airline/vim-airline'
-- Plug 'vim-airline/vim-airline-themes'
-- Plug 'mattn/vim-gist' | Plug 'mattn/webapi-vim'
-- nvim-ufo - Better code folding
-- mini.nvim - Collection of useful tools

require("config.lazy")
local theme = require('theme_utils')

------------------------
--[[ Editor Visuals ]]--
------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.signcolumn = "auto"
vim.o.cursorline = true
vim.o.colorcolumn = "100"
vim.o.shortmess = "astoOCF"
vim.o.display = ""

vim.keymap.set('n', '<F10>', theme.show_highlight_groups)
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = "HighlightedyankRegion",
      timeout = 2000,
    })
  end,
  pattern = '*',
})
vim.api.nvim_set_hl(0, "HighlightedyankRegion", { bg = "#ebdbb2", fg = "#928374" })

-------------------------
--[[ Editor Behavior ]]--
-------------------------
vim.o.mouse = "a"
vim.o.selectmode = "mouse"
vim.o.shada = ""
vim.o.writebackup = false
vim.o.undofile = true
vim.o.autowrite = true
vim.o.confirm = true

vim.o.timeoutlen = 2000
vim.o.ttimeoutlen = 10
vim.o.lazyredraw = true

vim.o.splitright = true
vim.o.splitbelow = true

-- vim.o.completeopt = "menu,menuone,noselect,noinsert,preview"
vim.o.completeopt = "menu,menuone,noselect,longest,preview"
vim.o.whichwrap = "<,>,h,l,[,],s,b"

vim.g.is_bash = 1

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.foldlevel = 3
vim.o.foldcolumn = "auto:3"
vim.o.foldopen = vim.opt.foldopen:append("jump")

vim.o.diffopt="filler,closeoff,algorithm:histogram,iwhite,linematch:90"

require('pulse').setup()

function open_quickfix_files()
  -- Close the quickfix window and open all files in the quickfix list
  vim.cmd('cclose')
  vim.cmd('silent cfdo e')
  vim.cmd('bufdo set ei-=Syntax | do Syntax')
end
vim.api.nvim_create_user_command('OpenQuickfixFiles', open_quickfix_files, {})

-- Map Shift-Arrow to move between windows
vim.keymap.set('n', '<S-Up>', '<C-w>k', { desc = "Move to window above" })
vim.keymap.set('n', '<S-Down>', '<C-w>j', { desc = "Move to window below" })
vim.keymap.set('n', '<S-Left>', '<C-w>h', { desc = "Move to window left" })
vim.keymap.set('n', '<S-Right>', '<C-w>l', { desc = "Move to window right" })

vim.keymap.set('v', '<S-Up>', 'k', { desc = "Move selection up" })
vim.keymap.set('v', '<S-Down>', 'j', { desc = "Move selection down" })

-------------------------
--[[ Text Formatting ]]--
-------------------------
vim.o.breakindent = true
vim.o.wrap = false

vim.o.shiftround = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.sidescroll = 1

vim.o.showmatch = true

vim.opt.fileformats:append("mac")

-- Preview substitution live as you type
vim.o.inccommand = "split"

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:append("c")
    vim.opt_local.formatoptions:append("l")
    vim.opt_local.formatoptions:append("j")
    vim.opt_local.formatoptions:append("r")
    vim.opt_local.formatoptions:append("q")

    vim.opt_local.formatoptions:remove("o")
  end,
})

vim.o.list = true
vim.api.nvim_set_hl(0, "NonText", { fg = "#458588", bold = true, italic = false})

vim.api.nvim_set_hl(0, "Whitespace", { fg = "red", italic = false})
vim.o.listchars = "tab:❮-❯,trail:•,extends:→,precedes:←,nbsp:␣"

-- Set trailing whitespace to be red in all files
vim.api.nvim_create_autocmd("FileType", { pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Whitespace", { fg = "red", italic = false})
    vim.o.listchars = "tab:❮-❯,trail:•,extends:→,precedes:←,nbsp:␣"
  end
})

-- Except go, we'll handle that separately because of leading tabs
vim.api.nvim_create_autocmd("FileType", { pattern = "go",
  callback = function()
    vim.fn.matchadd("InvalidWhitespace", [[^\s* \+]])
    vim.api.nvim_set_hl(0, "Whitespace", { fg = "#504945" })
    vim.api.nvim_set_hl(0, "InvalidWhitespace", { fg = "red" })
    vim.o.listchars = "tab:│ ,trail:•,extends:→,precedes:←,nbsp:␣"
  end
})

vim.api.nvim_create_autocmd("FileType", { pattern = "gitcommit",
  callback = function() vim.fn.clearmatches() end,
})

vim.api.nvim_create_autocmd("FileType", { pattern = "just",
  callback = function() vim.fn.clearmatches() end,
})

------------------
--[[ Mappings ]]--
------------------

-- <Leader>ws -- Clear whitespace
vim.keymap.set('n', '<Leader>ws', function()
    local cursor_pos = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', cursor_pos)
end)

-- Disable ex-mode (Q) and command window (q:)
vim.keymap.set('n', 'Q', '<Nop>', { noremap = true })
vim.keymap.set('n', 'q:', '<Nop>', { noremap = true })

-- Create command aliases for common typos
vim.api.nvim_create_user_command('WQ', function(opts)
  vim.cmd('wq' .. (opts.bang and '!' or ''))
end, { bang = true })

vim.api.nvim_create_user_command('Wq', function(opts)
  vim.cmd('wq' .. (opts.bang and '!' or ''))
end, { bang = true })

vim.api.nvim_create_user_command('W', function(opts)
  vim.cmd('w' .. (opts.bang and '!' or ''))
end, { bang = true })

vim.api.nvim_create_user_command('Q', function(opts)
  vim.cmd('quit' .. (opts.bang and '!' or ''))
end, { bang = true })

-- eff those new lines
vim.keymap.set('n', '<Leader>ftnl', function()
  vim.cmd([[%s/\\n/\r/ge]])
end, { noremap = true })

-- <Leader>w -- soft wrap lines at 100 chars
-- <Leader>s -- or 50 chars
local wrap = [[<cmd>normal! mw<CR>:set linebreak textwidth=%d<CR>:%%!fold -sw %d<CR>:set nolinebreak<CR>:normal! `w<CR>]]
vim.keymap.set('n', '<leader>w', wrap:format(100, 100), { noremap = true })
vim.keymap.set('n', '<leader>s', wrap:format(50, 50), { noremap = true })

-- :Wrap -- Toggle wrap and linebreak
vim.api.nvim_create_user_command('Wrap', function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.opt.linebreak = not vim.opt.linebreak:get()
end, {})

-- :Nowrap -- Disable wrap and linebreak
vim.api.nvim_create_user_command('Nowrap', function()
  vim.opt.wrap = false
  vim.opt.linebreak = false
end, {})

-- :42Short -- Set textwidth and fold to specified count (defaults to 100)
vim.api.nvim_create_user_command('Short', function(opts)
  local count = opts.count or 100
  vim.opt.textwidth = count
  vim.cmd(string.format('%%!fold -sw %d', count))
end, { count = 100, bar = true })

-----------------------
--  [[ File Types ]] --
-----------------------

-- set 2 space tabs for the following filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua,javascript,javascript.jsx,coffee,ruby,haml,eruby,yaml,sass,cucumber",
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.zsh-theme",
  callback = function() vim.bo.filetype = 'zsh' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Gemfile", "Guardfile", "VagrantFile", "*.pp" },
  callback = function() vim.bo.filetype = 'ruby' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "nginx.conf.*",
  callback = function() vim.bo.filetype = 'nginx' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {"*.conf.mac", "*.conf.linux"},
  callback = function() vim.bo.filetype = 'conf' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "Dockerfile.tmpl",
  callback = function() vim.bo.filetype = 'dockerfile' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*tmux.conf*",
  callback = function() vim.bo.filetype = 'tmux' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.php",
  callback = function() vim.bo.filetype = 'php' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.html",
  callback = function() vim.bo.filetype = 'html.php' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.jsx",
  callback = function() vim.bo.filetype = 'javascript.jsx' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.tsx",
  callback = function() vim.bo.filetype = 'javascript.tsx' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.pyx",
  callback = function() vim.bo.filetype = 'python' end,
})

-- http://vi.stackexchange.com/questions/137/how-do-i-edit-crontab-files-with-vim-i-get-the-error-temp-file-must-be-edited
-- crontab must be edited 'in place'
vim.api.nvim_create_autocmd("FileType", {
  pattern = "crontab",
  command = "setlocal nobackup nowritebackup noswapfile"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4"
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "/usr/local/src/wistia/wistia-setup/**.sh",
  callback = function() vim.opt_local.expandtab = false end,
})

-----------------------
-- [[ OpenBrowser ]] --
-----------------------

-- let g:openbrowser_github_always_used_branch='master'
-- let g:openbrowser_github_url_exists_check='ignore'
-- let g:openbrowser_github_always_use_commit_hash=0

---------------
-- [[ FZF ]] --
---------------

-- let g:fzf_buffers_jump = 1
-- let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
-- let g:fzf_preview_window = ['up:60%', 'ctrl-/']
--
-- " Use fzf for quick file jumping
-- nnoremap <Leader><Space> :GFiles ':!:vendor/*'<CR>
-- " Use fzf for quick buffer jumping
-- nnoremap <Leader>b :Buffers<CR>
-- " Use fzf for quick git-status
-- nnoremap <Leader>gs :GFiles?<CR>
-- " Use fzf for quick searching
-- nnoremap <Leader>/ :Lines<CR>
-- " search contents of files
-- nnoremap <Leader>a :AgIgnoreTests<CR>
-- " nnoremap <Leader>p PT Integration here

------------------
-- [[ FZF AG ]] --
------------------

-- let s:fzf_ag_options = "--ignore-dir=vendor --ignore-dir=node_modules --ignore-dir=spec --ignore-dir='.git' --hidden --ignore='*_test.go' --ignore=case"
-- command! -bang -nargs=* AgIgnoreTests call fzf#vim#ag(<q-args>, s:fzf_ag_options, fzf#vim#with_preview(), <bang>0)

------------------
-- [[ Vim-go ]] --
------------------

-- " vim-go should use only quickfix instead of mixture of quickfix and locationlist
-- let g:go_list_type = "quickfix"
-- " vim-go increase test timeout to 30s, we are async so the delay is ok
-- let g:go_test_timeout = '30s'
-- " use `go imports` which updates import packages as well as doing normal `go fmt` stuff
-- let g:go_fmt_command = "goimports"

-------------------
-- [[ Airline ]] --
-------------------

-- let g:airline_theme='base16_gruvbox_dark_hard'
-- let g:airline_powerline_fonts=0
-- let g:airline_symbols_ascii=1
-- let g:airline_left_sep=''
-- let g:airline_right_sep=''
-- let g:airline_left_sep_alt='|'
-- let g:airline_right_sep_alt='|'
--
-- let g:airline_highlighting_cache = 1
--
-- function! AirlineThemePatch(palelelette)
--   " let g:airline#themes#base16_gruvbox_dark_hard#palette
--
--   let a:palette.normal.airline_a = ['#ebdbb2', '#504945', 222, 236, '']
--   let a:palette.normal.airline_c = ['#ebdbb2', '#3c3836', 222, 236, '']
--   let a:palette.normal.airline_z = ['#ebdbb2', '#504945', 222, 236, '']
--
--   let a:palette.insert.airline_c = ['#83a598', '#3c3836', 222, 236, '']
--   let a:palette.visual.airline_c = ['#d3869b', '#3c3836', 222, 236, '']
--
--   for mode in values(a:palette)
--     let mode.airline_warning = ['#fb4934', '#504945', 232, 166]
--   endfor
-- endfunction
-- let g:airline_theme_patch_func = 'AirlineThemePatch'
--
-- let g:airline_section_y=''
-- let g:airline_skip_empty_sections=1
-- let g:airline#extensions#wordcount#enabled=0
-- let g:airline#extensions#tabline#enabled=0
-- let g:airline#extensions#tabline#show_tab_nr=1
-- let g:airline#extensions#tabline#buffer_idx_mode=1
-- let g:airline#extensions#tabline#show_tab_type = 0
--
-- " `+5` instead of `+5 -0 ~0`
-- let g:airline#extensions#hunks#non_zero_only = 1
--
-- " show only the last segment of the branch name, i.e `morr/feat` becomes `feat`
-- let g:airline#extensions#branch#format = 1
--
-- " Truncate branch name to the _first_ 30 chars
-- " let g:airline#extensions#branch#displayed_head_limit = 30
--
-- " Truncate branch name to the _last_ 30 chars
-- let g:airline#extensions#branch#format = 'CustomBranchName'
-- function! CustomBranchName(name)
--   return a:name[-30:]
-- endfunction
--
-- nmap <leader>1 <Plug>AirlineSelectTab1
-- nmap <leader>2 <Plug>AirlineSelectTab2
-- nmap <leader>3 <Plug>AirlineSelectTab3
-- nmap <leader>4 <Plug>AirlineSelectTab4
-- nmap <leader>5 <Plug>AirlineSelectTab5
-- nmap <leader>6 <Plug>AirlineSelectTab6
-- nmap <leader>7 <Plug>AirlineSelectTab7
-- nmap <leader>8 <Plug>AirlineSelectTab8
-- nmap <leader>9 <Plug>AirlineSelectTab9
-- nmap <leader>- <Plug>AirlineSelectPrevTab
-- nmap <leader>+ <Plug>AirlineSelectNextTab
-- let g:airline#extensions#tabline#buffer_min_count=1
-- let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
--
-- let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', '(%v)'])
-- let g:airline_symbols.linenr = '№ '
-- let g:airline_mode_map = {'__':'───', 'n':'Nor', 'i':'Ins', 'R':'Rep', 'v':'Vis', 'V':'V-L', '':'V-B', 'c':'Cmd', 's':'Sel', 'S':'S-L', '':'S-B', 't':'Ter', }

-- vim:set ft=lua et sw=2:
