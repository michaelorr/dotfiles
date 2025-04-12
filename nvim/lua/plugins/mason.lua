-- Mason is a package manager for LSP servers, DAP servers, linters, and formatters.

-- TODO: Read configs and docs
-- TODO: Install more language support

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

     -- First, set up mason.nvim itself to install all tools
     local mason_registry = require("mason-registry")
     local tools = {
       -- -- Formatters
       -- "prettier",
       -- "gofumpt",
       -- "goimports",
       -- "shfmt",
       -- "fixjson",
       -- "terraform-ls",
       -- -- Linters
       -- "shellcheck",
       -- "hadolint",
       -- "yamllint",
       -- "markdownlint",
       -- "sqlfluff",
     }

     for _, tool in ipairs(tools) do
       if not mason_registry.is_installed(tool) then
         mason_registry.get_package(tool):install()
       end
     end

      -- Then set up mason-lspconfig with only LSP servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "docker_compose_language_service",
          "dockerls",
          "eslint",
          "golangci_lint_ls",
          "gopls",
          "graphql",
          "helm_ls",
          "jsonls",
          "marksman",
          "lua_ls",
          "rubocop",
          "ruby_lsp",
          "solargraph",
          "sqlls",
          "terraformls",
          "tflint",
          "ts_ls",
          "yamlls",
        },
        automatic_installation = true,
      })
    end,
  },
}
