-- Normal mode:
-- gd              Go to definition
-- K               Show hover
-- gi              Go to implementation
-- <leader>rn      Rename
-- gr              Go to references

-- NOTE: I have not yet looked at docs for more default keymaps / commands
-- TODO: Fix Format on save

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim",           lazy = false },
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

        --   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        --   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        --   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        --   vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        --   -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        --   -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        --   -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      end

      local lspconfig = require('lspconfig')
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local default_cfg = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- simple servers requiring no extra configuration
      local std_servers = {
        'bashls',
        'docker_compose_language_service',
        'dockerls',
        "eslint",
        'graphql',
        'marksman',
        'rubocop',
        'ruby_lsp',
        'solargraph',
        'sqlls',
        'terraformls',
        'tflint',
        "ts_ls",
      }

      for _, server in ipairs(std_servers) do
        lspconfig[server].setup(default_cfg)
      end

      --------------------------------------
      -- Helm --
      -- https://github.com/mrjosh/helm-ls
      --------------------------------------
      lspconfig.helm_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = "yaml-language-server",
            }
          }
        }
      }

      ----------------------------------------------------
      -- Gopls --
      -- https://github.com/golang/tools/tree/master/gopls
      ----------------------------------------------------
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              unusedvariable = true,
              unusedvar = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          -- buf_request_sync defaults to a 1000ms timeout. Depending on your
          -- machine and codebase, you may want longer. Add an additional
          -- argument after params if you find that you have to write the file
          -- twice for changes to be saved.
          -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          vim.lsp.buf.format({ async = false })
        end
      })

      -------------------------------------------------------
      -- Golangci-lint
      -- https://github.com/nametake/golangci-lint-langserver
      -------------------------------------------------------
      local configs = require 'lspconfig/configs'

      if not configs.golangcilsp then
        configs.golangcilsp = {
          default_config = {
            root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
            init_options = {
              command = {
                "golangci-lint",
                "run",
                "--output.json.path",
                "stdout",
                "--show-stats=false",
                "--issues-exit-code=1",
              },
            }
          },
        }
      end
      lspconfig.golangci_lint_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'go', 'gomod' }
      }

      --------------------------------------
      -- yamlls --
      -- https://github.com/redhat-developer/yaml-language-server
      --------------------------------------
      lspconfig.yamlls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          yaml = {
            schemas = {
              -- kubernetes = "*.yaml",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
              ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "/*.k8s.yaml",
            },
          },
        },
      }

      -----------------------------------------------
      -- luals
      -- https://github.com/luals/lua-language-server
      -----------------------------------------------
      require 'lspconfig'.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                quote_style = "auto",
                line_width = "80",
                column_limit = "80",
                use_tabs = false,
                insert_final_newline = true,
              }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      }

      ------------------------------------
      -- JSON
      ------------------------------------
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          }
        }
      })

      -- -- TypeScript/JavaScript
      -- require('lspconfig').ts_ls.setup({
      -- capabilities = capabilities,
      -- on_attach = on_attach,
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
      -- capabilities = capabilities,
      -- on_attach = on_attach,
      -- })
    end
  }
}
