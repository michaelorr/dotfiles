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
vim.o.smartindent = true

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

-- vim.o.listchars = "tab:❮-❯,trail:•,extends:→,precedes:←,nbsp:␣"
vim.api.nvim_set_hl(0, "WhitespaceRed", { fg = "red", italic = false })

-- Set trailing whitespace to be red in all files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- Whitespace detected by listchars should have red fg in all filetypes by default. Overriden below for a few filetypes.

    -- vim.api.nvim_set_hl(0, "Whitespace", { fg = "red", italic = false})
    vim.cmd("set winhighlight=Whitespace:WhitespaceRed")
    vim.opt_local.listchars = "tab:❮-❯,trail:•,extends:→,precedes:←,nbsp:␣"
  end
})

-- Except go, we'll handle that separately because of leading tabs
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"go", "just", "make"},
  callback = function()
    vim.opt_local.listchars = "tab:│ ,trail:•,extends:→,precedes:←,nbsp:␣"
    vim.fn.matchadd("InvalidWhitespace", [[^\s* \+]])
    vim.fn.matchadd("InvalidWhitespace", [[\s\+$]])
    -- Override the above

    -- vim.api.nvim_set_hl(0, "InvalidWhitespace", {fg = "red" })
    -- vim.api.nvim_set_hl(0, "Whitespace", { link = "GoTabs" })
    vim.cmd("set winhighlight=Whitespace:GoTabs,InvalidWhitespace:WhitespaceRed")
  end
})

vim.cmd('silent! doautoall WhiteSpaceHighlight BufEnter')
