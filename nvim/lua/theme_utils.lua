local M = {}

M.show_highlight_groups = function()
    local ts_captures = vim.treesitter.get_captures_at_cursor(0)
    local syn_id = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
    local syn_name = vim.fn.synIDattr(syn_id, 'name')

    -- Create content
    local content = {
        " Treesitter: " .. vim.inspect(ts_captures) .. " ",
        " Vim syntax: " .. syn_name .. " ",
    }

    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, content)

    local LABEL_LENGTH = 12
    local PADDING = 2

    local win_height = vim.api.nvim_win_get_height(0)
    local win_width = vim.api.nvim_win_get_width(0)

    local width = math.min(
      math.max(
        vim.api.nvim_strwidth(vim.inspect(ts_captures)),
        vim.api.nvim_strwidth(syn_name)
      ) + LABEL_LENGTH + PADDING,
      win_width - PADDING
    )

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = 2,
        row = math.floor(win_height / 2) - 1,
        col = math.floor((win_width - width) / 2),
        style = 'minimal',
        border = 'rounded',
        title = ' Highlight Info ',
        title_pos = 'center',
        zindex = 100
    })

    -- Add some style
    vim.api.nvim_win_set_option(win, 'winblend', 10)
    vim.api.nvim_buf_add_highlight(buf, -1, 'Title', 0, 0, LABEL_LENGTH)  -- "Treesitter: "
    vim.api.nvim_buf_add_highlight(buf, -1, 'Title', 1, 0, LABEL_LENGTH)  -- "Vim syntax: "

    -- Force redraw
    vim.cmd('redraw')

    -- Wait for keypress and cleanup
    vim.fn.getchar()
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
end

return M
