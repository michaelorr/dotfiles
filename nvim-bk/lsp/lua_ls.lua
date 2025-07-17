-----------------------------------------------
-- luals
-- https://github.com/luals/lua-language-server
-----------------------------------------------

return {
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
