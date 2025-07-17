return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function linenr()
      return vim.api.nvim_win_get_cursor(0)[1]
    end
    require('lualine').setup({
      options = {
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        gloabalstatus = true,
      },
      sections = {
        lualine_b = { 'diff', 'diagnostics' },
        lualine_x = { 'filetype', },
        lualine_y = {
          { 'progress', padding = { left = 1, right = 0 } },
          { linenr,     padding = { left = 0, right = 1 } },
        },
        lualine_z = { 'searchcount' },
      }
    })
  end,
}

-- sections = {
--   lualine_a = {
--     {
--       'diagnostics',

--       -- Table of diagnostic sources, available sources are:
--       --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
--       -- or a function that returns a table as such:
--       --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
--       sources = { 'nvim_diagnostic', 'coc' },

--       -- Displays diagnostics for the defined severity types
--       sections = { 'error', 'warn', 'info', 'hint' },

--       diagnostics_color = {
--         -- Same values as the general color option can be used here.
--         error = 'DiagnosticError', -- Changes diagnostics' error color.
--         warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
--         info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
--         hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
--       },
--       symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
--       colored = true,           -- Displays diagnostics status in color if set to true.
--       update_in_insert = false, -- Update diagnostics in insert mode.
--       always_visible = false,   -- Show diagnostics even if there are none.
--     }
--   }
-- }
-- sections = {
--   lualine_a = {
--     {
--       'filename',
--       file_status = true,      -- Displays file status (readonly status, modified status)
--       newfile_status = false,  -- Display new file status (new file means no write after created)
--       path = 0,                -- 0: Just the filename
--                                -- 1: Relative path
--                                -- 2: Absolute path
--                                -- 3: Absolute path, with tilde as the home directory
--                                -- 4: Filename and parent dir, with tilde as the home directory

--       shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
--                                -- for other components. (terrible name, any suggestions?)
--       symbols = {
--         modified = '[+]',      -- Text to show when the file is modified.
--         readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
--         unnamed = '[No Name]', -- Text to show for unnamed buffers.
--         newfile = '[New]',     -- Text to show for newly created file before first write
--       }
--     }
--   }
-- }


-- sections = {
--   lualine_a = {
--     {
--       'filetype',
--       colored = true,   -- Displays filetype icon in color if set to true
--       icon_only = false, -- Display only an icon for filetype
--       icon = { align = 'right' }, -- Display filetype icon on the right hand side
--       -- icon =    {'X', align='right'}
--       -- Icon string ^ in table is ignored in filetype component
--     }
--   }
-- }
--
--
-- sections = {
--   lualine_a = {
--     {
--       'lsp_status',
--       icon = '', -- f013
--       symbols = {
--         -- Standard unicode symbols to cycle through for LSP progress:
--         spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
--         -- Standard unicode symbol for when LSP is done:
--         done = '✓',
--         -- Delimiter inserted between LSP names:
--         separator = ' ',
--       },
--       -- List of LSP names to ignore (e.g., `null-ls`):
--       ignore_lsp = {},
--     }
--   }
-- }
