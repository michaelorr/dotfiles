local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "gruvbox" } },
  rocks = { hererocks = false },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- vim.lsp.enable({
--   "bashls",
--   "gopls",
--   "lua_ls",
--   "golangci_lint_ls",
--   "docker_compose_language_service",
--   "dockerls",
--   "ruby_lsp",
--   "ts_ls",
--   "graphql",
--   -- "marksman",
--   -- "sqlls",
--   -- "terraformls",
--   -- "tflint",
--   -- "helm_ls",
--   -- "yamlls",
--   -- "jsonls",
-- })

-- local base_on_attach = vim.lsp.config.eslint.on_attach
-- vim.lsp.config("eslint", {
--   on_attach = function(client, bufnr)
--     if not base_on_attach then return end
--
--     base_on_attach(client, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "LspEslintFixAll",
--     })
--   end,
-- })
-- vim.lsp.enable("eslint")

-- ----------------------------------------
-- -- Helm --
-- -- https://github.com/mrjosh/helm-ls
-- ----------------------------------------
-- lspconfig.helm_ls.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     ['helm-ls'] = {
--       yamlls = {
--         path = "yaml-language-server",
--       }
--     }
--   }
-- }

-- --------------------------------------
-- -- yamlls --
-- -- https://github.com/redhat-developer/yaml-language-server
-- --------------------------------------
-- lspconfig.yamlls.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     yaml = {
--       schemaStore = {
--         enable = true,
--         url = "https://www.schemastore.org/json":
--       },
--       schemas = {
--         -- kubernetes = "*.yaml",
--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
--         ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
--         ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--         ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
--         ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
--         ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
--         ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
--         ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
--         ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
--         ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
--         ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "/*.k8s.yaml",
--         ["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/main/docs-v2/content/en/schemas/v3.json"] = "/*.skaffold.yaml",
--       },
--     },
--   },
-- }

-- lspconfig.jsonls.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     json = {
--       format = {
--         enable = true,
--       },
--       validate = { enable = true },
--     }
--   }
-- })
