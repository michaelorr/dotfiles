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
vim.opt.complete:append("kspell")
vim.o.whichwrap = "<,>,h,l,[,],s,b"

vim.g.is_bash = 1

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
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

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = "HighlightedyankRegion",
      timeout = 2000,
    })
  end,
  pattern = '*',
})

require('config.mappings')
