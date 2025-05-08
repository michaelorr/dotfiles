-- Mason is a package manager for LSP servers, DAP servers, linters, and formatters.

-- TODO: Read configs and docs
-- TODO: Install more language support

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
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

      local mason_registry = require("mason-registry")
      local tools = {
        "bash-language-server",
        "shellcheck", -- used by bashls under the hood
        "shfmt",      -- used by bashls under the hood
        "docker-compose-language-service",
        "dockerfile-language-server",
        "golangci-lint-langserver",
        "lua-language-server",

        -- unverified --

        -- "eslint-lsp",
        -- "helm-ls",
        -- "json-lsp",
        -- "marksman",
        -- "sqlls",
        -- "terraform-ls",
        -- "tflint",
        -- "typescript-language-server",
        -- "yaml-language-server",
      }

      for _, tool in ipairs(tools) do
        if not mason_registry.is_installed(tool) then
          mason_registry.get_package(tool):install()
        end
      end
    end,
  },
}
