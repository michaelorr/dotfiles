------------------
--[[ Mappings ]]--
------------------

-- <leader>s -- Search and replace the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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

-- :WrapToggle -- Toggle wrap and linebreak
vim.api.nvim_create_user_command('WrapToggle', function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.opt.linebreak = not vim.opt.linebreak:get()
end, {})

-- :60Wrap -- Set textwidth and fold to specified count (defaults to 100)
vim.api.nvim_create_user_command('Wrap', function(opts)
  vim.cmd('normal! mw')
  vim.opt.linebreak = true
  vim.opt.textwidth = opts.count
  vim.cmd(string.format('%%!fold -sw %d', opts.count))
  vim.opt.linebreak = false
  vim.cmd('normal `w\\ws')
end, { count = 100 })

-- delete the last `word` with C-\ in insert mode
vim.keymap.set('i', '<C-\\>', '<c-w>', { noremap = true })

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
