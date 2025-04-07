-- Normal mode:
-- gd              Go to definition
-- K               Show hover
-- gi              Go to implementation
-- <leader>rn      Rename
-- gr              Go to references

-- NOTE: I have not yet looked at docs for more default keymaps / commands
-- TODO: Configure plugin in general and more keymaps
-- TODO: Fix Format on save
-- TODO: Configure more languages

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim", lazy = false },
      { "williamboman/mason-lspconfig.nvim", lazy = false },
    },

    config = function()
      -- LSP keybindings
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Format on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                -- If we do this async, it will modify the buffer after it has been saved :(
                async = false,
                -- filter = function(client)
                --   return client.name == "null-ls"
                -- end,
              })
            end,
          })
        end

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      end

      -- Ruby
      require('lspconfig').ruby_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- -- Go
      -- require('lspconfig').gopls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = {
      --     gopls = {
      --       analyses = {
      --         unusedparams = true,
      --       },
      --       staticcheck = true,
      --     },
      --   },
      -- })

      -- -- Bash/Zsh
      -- require('lspconfig').bashls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   filetypes = { "sh", "bash", "zsh" },
      -- })

      -- -- Terraform
      -- require('lspconfig').terraformls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- -- Docker
      -- require('lspconfig').dockerls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- require('lspconfig').docker_compose_language_service.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- -- YAML (Kubernetes)
      -- require('lspconfig').yamlls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "/*.k8s.yaml",
      --       },
      --     },
      --   },
      -- })

      -- -- Markdown
      -- require('lspconfig').marksman.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- -- SQL
      -- require('lspconfig').sqlls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- -- JSON
      -- require('lspconfig').jsonls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- -- TypeScript/JavaScript
      -- require('lspconfig').ts_ls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = {
      --     typescript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = 'all',
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayFunctionParameterTypeHints = true,
      --         includeInlayVariableTypeHints = true,
      --         includeInlayPropertyDeclarationTypeHints = true,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayEnumMemberValueHints = true,
      --       }
      --     },
      --     javascript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = 'all',
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayFunctionParameterTypeHints = true,
      --         includeInlayVariableTypeHints = true,
      --         includeInlayPropertyDeclarationTypeHints = true,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayEnumMemberValueHints = true,
      --       }
      --     }
      --   }
      -- })

      -- -- ESLint
      -- require('lspconfig').eslint.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      -- -- JSON
      -- require('lspconfig').jsonls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = {
      --     json = {
      --       format = {
      --         enable = true,
      --       },
      --       validate = { enable = true },
      --     }
      --   }
      -- })
    end
  }
}
