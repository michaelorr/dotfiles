------------------
--[[ Mappings ]]--
------------------
-- vim.keymap.set("n", "<leader>z", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
-- vim.keymap.set("n", "<leader>x", vim.cmd.Ex, { desc = "Toggle file explorer" })

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list" })
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list" })

-- Set a cursor mark for J so that we don't jump to the end of the line
vim.keymap.set('n', "J", 'mzJ`z', { desc = "Join lines without moving cursor" })

-- Paste without losing register contents
vim.keymap.set('x', '<leader>p', "\"_dP", { desc = "Paste from clipboard" })

-- Shift-Arrow to moves between windows in Normal mode
vim.keymap.set('n', '<S-Up>', '<C-w>k', { desc = "Move to window above" })
vim.keymap.set('n', '<S-Down>', '<C-w>j', { desc = "Move to window below" })
vim.keymap.set('n', '<S-Left>', '<C-w>h', { desc = "Move to window left" })
vim.keymap.set('n', '<S-Right>', '<C-w>l', { desc = "Move to window right" })

-- Shift-arrow keys moves selection in Visual mode
vim.keymap.set('v', '<S-Up>', 'k', { desc = "Move selection up" })
vim.keymap.set('v', '<S-Down>', 'j', { desc = "Move selection down" })

-- Disable shift-arrow keys in Insert mode
vim.keymap.set('i', '<S-Up>', '<nop>' )
vim.keymap.set('i', '<S-Down>', '<nop>' )

-- Escape clears search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

-- delete the last `word` with C-\ in insert mode
vim.keymap.set('i', '<c-\\>', '<c-w>', { noremap = true })

-- Toggle quickfix window
function toggle_quickfix()
    local quickfix_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            quickfix_exists = true
            break
        end
    end

    if quickfix_exists then
        vim.cmd('cclose')
    else
        vim.cmd('copen')
    end
end
vim.keymap.set('n', '<leader>q', toggle_quickfix, { silent = true, desc = "Toggle quickfix" })
