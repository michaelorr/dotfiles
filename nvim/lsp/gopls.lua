----------------------------------------------------
-- Gopls --
-- https://github.com/golang/tools/tree/master/gopls
----------------------------------------------------

return {
  cmd = { "gopls" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedvariable = true,
        unusedvar = true,
        shadow = true,
        ST1005 = false, -- error strings should not be capitalized
      },
      staticcheck = true,
      gofumpt = true,
    },
  }
}
