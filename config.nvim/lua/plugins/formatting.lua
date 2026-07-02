-- Lockfiles are generated; don't reformat them on save.
-- yamlls (LazyVim yaml extra) enables LSP formatting for yaml buffers, which
-- ignores .prettierignore and .oxfmtrc.json ignorePatterns.
local lockfile_patterns = {
  "pnpm-lock.yaml",
  "package-lock.json",
  "yarn.lock",
  "bun.lock",
  "bun.lockb",
  "Gemfile.lock",
  "poetry.lock",
  "Cargo.lock",
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("lazyvim-no-format-lockfiles", { clear = true }),
  pattern = lockfile_patterns,
  callback = function(event)
    vim.b[event.buf].autoformat = false
  end,
})
