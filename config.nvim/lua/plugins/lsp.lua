return {
  --   {
  --     "neovim/nvim-lspconfig",
  --     opts = {
  --       servers = { eslint = {} },
  --       setup = {
  --         eslint = function()
  --           require("lazyvim.util").lsp.on_attach(function(client)
  --             if client.name == "eslint" then
  --               client.server_capabilities.documentFormattingProvider = true
  --             elseif client.name == "tsserver" then
  --               client.server_capabilities.documentFormattingProvider = false
  --             end
  --           end)
  --         end,
  --       },
  --     },
  --   },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Define specific servers
      local servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
        },
        rubocop = {},
        marksman = {},
      }

      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, servers)

      -- Apply global keybindings to all servers
      opts.setup = vim.tbl_deep_extend("force", opts.setup or {}, {
        ["*"] = function(server, server_opts)
          -- Disable specific keybindings for all servers
          local keys = vim.tbl_get(server_opts, "keys") or {}
          vim.list_extend(keys, {
            { "<Leader>cc", false },
            { "<Leader>cC", false },
          })
          server_opts.keys = keys

          -- Set position encoding for all servers
          server_opts.capabilities = vim.tbl_deep_extend("force", server_opts.capabilities or {}, {
            general = {
              positionEncodings = { "utf-16" },
            },
          })
        end,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "markdownlint-cli2",
        "markdown-toc",
      },
    },
  },
}
