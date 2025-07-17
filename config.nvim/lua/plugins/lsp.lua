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
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
        },
        rubocop = {
          mason = false,
          cmd = { vim.fn.expand("~/.asdf/shims/rubocop") },
        },
        marksman = {},
      })

      opts.capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
        general = {
          positionEncodings = { "utf-16" }, -- Set the offset encoding, see `:h vim.lsp.start` for more info
        },
      })

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<Leader>cc", false }
      keys[#keys + 1] = { "<Leader>cC", false }
    end,
  },

  {
    "williamboman/mason.nvim",
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
