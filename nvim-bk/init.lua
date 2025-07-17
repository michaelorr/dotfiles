-- Commands:
--     :{count}Wrap       Wrap lines at word break (default 100 chars)
--     :WrapToggle        Toggle linewrap and linebreak
--
-- Normal mode:
--     <Leader>o          Open all files from quickfix and close quickfix
--     <Leader>p          Paste without overwriting the clipboard
--     <Leader>w         Delete trailing whitespace
--     <Leader>ftnl       Convert newline chars
--     <Leader>q          Toggle quickfix window
--     <F10>              Show Highlight Groups under the cursor
--     <S-Up>             Move between windows
--     <S-Down>           Move between windows
--     <S-Left>           Move between windows
--     <S-Right>          Move between windows
--
-- Visual mode:
--     <S-Up>             Expand existing selection up
--     <S-Down>           Expand existing selection down
--
-- Insert mode:
--     <S-Up>             <nop>
--     <S-Down>           <nop>
--     <C-\>              Delete previous word from cursor position

-- Set leaders first so mappings are correct
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Init lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  install = { colorscheme = { 'gruvbox' } },
  spec = { { import = "plugins" } },
  checker = { enabled = true },
  rocks = { hererocks = false },
})

vim.lsp.enable({
  "bashls",
  "gopls",
  "lua_ls",
  "golangci_lint_ls",
  "docker_compose_language_service",
  "dockerls",
  "ruby_lsp",
  "ts_ls",
  "graphql",
  -- "marksman",
  -- "sqlls",
  -- "terraformls",
  -- "tflint",
  -- "helm_ls",
  -- "yamlls",
  -- "jsonls",
})

local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not base_on_attach then return end

    base_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,
})
vim.lsp.enable("eslint")

-- All other configs
require('config')

--   --------------------------------------
--   -- Helm --
--   -- https://github.com/mrjosh/helm-ls
--   --------------------------------------
--   lspconfig.helm_ls.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = {
--       ['helm-ls'] = {
--         yamlls = {
--           path = "yaml-language-server",
--         }
--       }
--     }
--   }

--     --------------------------------------
--     -- yamlls --
--     -- https://github.com/redhat-developer/yaml-language-server
--     --------------------------------------
--     lspconfig.yamlls.setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = {
--         yaml = {
--           schemaStore = {
--             enable = true,
--             url = "https://www.schemastore.org/json":
--           },
--           schemas = {
--             -- kubernetes = "*.yaml",
--             ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
--             ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
--             ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
--             ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--             ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
--             ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
--             ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
--             ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
--             ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
--             ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
--             ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
--             ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "/*.k8s.yaml",
--             ["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/main/docs-v2/content/en/schemas/v3.json"] = "/*.skaffold.yaml",
--           },
--         },
--       },
--     }

--   lspconfig.jsonls.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = {
--       json = {
--         format = {
--           enable = true,
--         },
--         validate = { enable = true },
--       }
--     }
--   })
