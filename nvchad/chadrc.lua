-- Just an example, supposed to be placed in /lua/custom/

-- remove this if you dont use custom.init.lua at all
require "custom"

local M = {}

M.plugins = require("custom.plugins")
M.mappings = require("custom.mappings")
M.ui = {
  theme = "tokyonight"
}

return M
