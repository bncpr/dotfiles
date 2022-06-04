local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- Lua
   b.formatting.stylua,

   -- Python
   b.formatting.autopep8,
   b.diagnostics.pylint,

   -- C/C++
   b.formatting.clang_format,
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
   }
end

return M
