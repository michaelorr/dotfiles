do
  local handler = vim.lsp.handlers["client/registerCapability"]
  if handler then
    vim.lsp.handlers["client/registerCapability"] = function(err, params, ctx, config)
      params = params or {}
      if params.registrations == nil then
        params.registrations = {}
      end
      return handler(err, params, ctx, config)
    end
  end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
