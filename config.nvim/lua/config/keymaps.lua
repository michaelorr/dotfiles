-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init

local map = vim.keymap.set
local del = vim.keymap.del

-- Unset default keymaps for resizing windows
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")

-- Unset default keymaps for moving lines
del({ "n", "i", "v" }, "<M-j>")
del({ "n", "i", "v" }, "<M-k>")

-- Override the default new tab mapping to also open a file chooser
del("n", "<leader><tab><tab>")
map("n", "<leader><tab><tab>", function()
  vim.cmd([[
    tabnew
  ]])
  LazyVim.pick("smart")()
end, { desc = "New Tab" })

del("n", "<leader>K")

-- Open all files in the quickfix list and close the quickfix window
local function open_quickfix_files()
  vim.cmd("cclose")
  vim.cmd("silent cfdo e")
  vim.cmd("bufdo set ei-=Syntax | do Syntax")
end
map("n", "<leader>xo", "<cmd>OpenQuickfixFiles<CR>", { desc = "Open quickfix files" })
vim.api.nvim_create_user_command("OpenQuickfixFiles", open_quickfix_files, {})

-- <leader>s -- Search and replace the word under the cursor
map(
  "n",
  "<leader>s.",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Find and replace word under cursor" }
)

-- Paste without losing register contents
map("x", "<leader>p", '"_dP', { desc = "Paste from clipboard" })

-- Disable shift-arrow keys in Insert mode
map("i", "<S-Up>", "<nop>")
map("i", "<S-Down>", "<nop>")

-- Shift-arrow keys moves selection in Visual mode
map("v", "<S-Up>", "k", { desc = "Move selection up" })
map("v", "<S-Down>", "j", { desc = "Move selection down" })

-- Shift-Arrow to moves between windows in Normal mode
map("n", "<S-Up>", "<C-w>k", { desc = "Move to window above" })
map("n", "<S-Down>", "<C-w>j", { desc = "Move to window below" })
map("n", "<S-Left>", "<C-w>h", { desc = "Move to window left" })
map("n", "<S-Right>", "<C-w>l", { desc = "Move to window right" })

-- Disable ex-mode (Q) and command window (q:)
map("n", "Q", "<Nop>", { noremap = true })
map("n", "q:", "<Nop>", { noremap = true })

-- Create command aliases for common typos
vim.api.nvim_create_user_command("WQ", function(opts)
  vim.cmd("wq" .. (opts.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("Wq", function(opts)
  vim.cmd("wq" .. (opts.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("W", function(opts)
  vim.cmd("w" .. (opts.bang and "!" or ""))
end, { bang = true })
vim.api.nvim_create_user_command("Q", function(opts)
  vim.cmd("quit" .. (opts.bang and "!" or ""))
end, { bang = true })

-- delete the last `word` with C-\ in insert mode
map("i", "<C-\\>", "<c-w>", { noremap = true })

map("n", "<leader>[", function()
  Snacks.explorer()
end, { desc = "File Explorer" })

map("n", "<leader>]", "<cmd>AerialToggle<cr>", { desc = "Aerial (Symbols)" })
map({ "n", "x" }, "<leader>gm", function()
  Snacks.gitbrowse.open({ branch = "main" })
end, { desc = "Open GitHub main branch" })
