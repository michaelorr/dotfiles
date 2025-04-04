-- TODO: Configure plugins and setup keymaps

-- Normal mode:
--  <leader><space> = find files
--  <leader>gf = git files
--  <leader>fg = live grep

return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  config = function()
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = 'close',
          },
          n = {
            ['<esc>'] = 'close',
          },
        },
      },
    }
    vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope git files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
  end
}
