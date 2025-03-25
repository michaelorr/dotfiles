-----------------------
--  [[ File Types ]] --
-----------------------

vim.api.nvim_create_autocmd("FileType", { pattern = "gitcommit",
  callback = function() vim.fn.clearmatches() end,
})

vim.api.nvim_create_autocmd("FileType", { pattern = "just",
  callback = function() vim.fn.clearmatches() end,
})

-- set 2 space tabs for the following filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua,javascript,javascript.jsx,coffee,ruby,haml,eruby,yaml,sass,cucumber",
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.zsh-theme",
  callback = function() vim.bo.filetype = 'zsh' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Gemfile", "Guardfile", "VagrantFile", "*.pp" },
  callback = function() vim.bo.filetype = 'ruby' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "nginx.conf.*",
  callback = function() vim.bo.filetype = 'nginx' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {"*.conf.mac", "*.conf.linux"},
  callback = function() vim.bo.filetype = 'conf' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "Dockerfile.tmpl",
  callback = function() vim.bo.filetype = 'dockerfile' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*tmux.conf*",
  callback = function() vim.bo.filetype = 'tmux' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.php",
  callback = function() vim.bo.filetype = 'php' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.html",
  callback = function() vim.bo.filetype = 'html.php' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.jsx",
  callback = function() vim.bo.filetype = 'javascript.jsx' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.tsx",
  callback = function() vim.bo.filetype = 'javascript.tsx' end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.pyx",
  callback = function() vim.bo.filetype = 'python' end,
})

-- http://vi.stackexchange.com/questions/137/how-do-i-edit-crontab-files-with-vim-i-get-the-error-temp-file-must-be-edited
-- crontab must be edited 'in place'
vim.api.nvim_create_autocmd("FileType", {
  pattern = "crontab",
  command = "setlocal nobackup nowritebackup noswapfile"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4"
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "/usr/local/src/wistia/wistia-setup/**.sh",
  callback = function() vim.opt_local.expandtab = false end,
})
