local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- Lua
   b.formatting.stylua,

   -- Python
   b.formatting.autopep8,

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
