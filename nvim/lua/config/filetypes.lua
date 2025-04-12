-----------------------
--  [[ File Types ]] --
-----------------------

vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  filename = {
    ["Dockerfile"] = "dockerfile",
  },
  pattern = {
    [".*/templates/.*%.tpl"]     = "helm",
    [".*/templates/.*%.ya?ml"]   = "helm",
    [".*/helmfile.*%.ya?ml"]     = "helm",
    [".*/deploy/.*%.ya?ml"]      = { "helm", { priority = 20 } },

    [".*/deploy/.*%.ya?ml%.tmpl"]    = "yaml",

    [".*/.*docker%-compose.*%.ya?ml"] = { "yaml.docker-compose", { priority = 100 } },
    [".*/.*docker%-compose.*%.json"] = { "json.docker-compose", { priority = 100 } },

    [".*/kustomization%.ya?ml"]  = { "yaml.kustomization", { priority = 10 } },
    [".*/kustomization%.json"]   = { "json.kustomization", { priority = 10 } },

    [".*/helmfile.*%.ya?ml"]     = { "yaml.helmfile", { priority = 10 } },
    [".*/helmfile.*%.json"]      = { "json.helmfile", { priority = 10 } },

    [".*/values%.ya?ml"]        = { "yaml.values", { priority = 20 } },
    [".*/values%.json"]         = { "json.values", { priority = 20 } },
  },
})

-- set 2 space tabs for the following filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml,lua,javascript,javascript.jsx,javascript.tsx,coffee,ruby,haml,eruby,yaml,sass,cucumber",
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
  pattern = { "go", "just", "make" },
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4"
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "/usr/local/src/wistia/wistia-setup/**.sh",
  callback = function() vim.opt_local.expandtab = false end,
})
