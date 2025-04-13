---------------------------
-- [[ Text Formatting ]] --
---------------------------
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

-- Whitespace detected by listchars should have red fg in all filetypes by default. Overriden below for a few filetypes.

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
    -- (hl-Whitespace is linked to hl-InvalidWhitespace in grubbox config)
    vim.o.list = true
    vim.opt_local.listchars = "tab:<->,trail:•,extends:→,precedes:←,nbsp:␣"
  end
})

-- 4. For these filetypes, leading tabs chars are common or valid, don't highlight them

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "just", "make", "help", "gitcommit", },
  callback = function()
    vim.opt_local.listchars = "tab:  ,trail:•,extends:→,precedes:←,nbsp:␣"
  end,
})

-- Turn off list mode and don't highlight whitespace in these filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "gitcommit", "TelescopePrompt", "TelescopeResults", "mason", },
  callback = function()
    vim.o.list = false
  end,
})

-- For go:
-- 5. Give tabs a vertical indicator
-- 6. Link the Whitespace highlight to the GoTab highlight (instead of InvalidWhitespace)
-- 7. Apply the InvalidWhitespace highlight to trailing spaces and mixed leading indent

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.listchars = "tab:│ ,trail:•,extends:→,precedes:←,nbsp:␣"
    vim.cmd("set winhighlight=Whitespace:GoTab")

    vim.fn.matchadd("InvalidWhitespace", [[^\s* \+]])
    vim.fn.matchadd("InvalidWhitespace", [[\s\+$]])
  end
})
