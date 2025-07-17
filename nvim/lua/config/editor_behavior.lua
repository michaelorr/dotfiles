-------------------------
--[[ Editor Behavior ]]
--
-------------------------
vim.o.mouse = "a"
vim.o.selectmode = "mouse"
vim.o.shada = ""
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.swapfile = false
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

-- Initializing the clipboard can be slow, do it async
vim.opt.clipboard = ""
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.foldlevel = 99
vim.o.foldcolumn = "auto:3"
vim.o.foldopen = vim.opt.foldopen:append("jump")

vim.o.diffopt = "filler,closeoff,algorithm:histogram,iwhite,linematch:90"
--    diffopt="internal,filler,closeoff,linematch:4"

require("pulse").setup()

-- Open all files in the quickfix list and close the quickfix window
local function open_quickfix_files()
	vim.cmd("cclose")
	vim.cmd("silent cfdo e")
	vim.cmd("bufdo set ei-=Syntax | do Syntax")
end
vim.keymap.set("n", "<leader>o", "<cmd>OpenQuickfixFiles<CR>", { desc = "Open quickfix files" })
vim.api.nvim_create_user_command("OpenQuickfixFiles", open_quickfix_files, {})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "HighlightedYankRegion",
			timeout = 2000,
		})
	end,
	pattern = "*",
})
