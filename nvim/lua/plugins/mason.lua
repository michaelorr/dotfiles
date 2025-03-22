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
          -- Ruby
          "ruby_lsp",

          -- -- JavaScript/TypeScript
          -- "ts_ls",
          -- "eslint",

          -- -- Go
          -- "gopls",

          -- -- Shell
          -- "bashls",  -- Changed from bash-language-server

          -- -- Infrastructure
          -- "terraformls",  -- Changed from terraform_lsp
          -- "dockerls",
          -- "docker_compose_language_service",
          -- "yamlls",

          -- -- Web
          -- "marksman",
          -- "sqlls",
          -- "jsonls",
        },
        automatic_installation = true,
      })
    end,
  },
}
