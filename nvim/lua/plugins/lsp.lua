return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim", lazy = false },
  },

  config = function()
    vim.diagnostic.config({
      virtual_text = false, -- Turn off inline diagnostics
    })

    vim.api.nvim_set_keymap(
      'n', '<Leader>d', "<cmd>Telescope diagnostics bufnr=0<CR>",
      { noremap = true, silent = true, desc = 'Diagnostics' }
    )

    vim.lsp.config("*", {
      on_attach = function(client, bufnr)
        -- Format on save
        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                async = false,
              })
            end,
          })
        end
      end
    })
  end
}
