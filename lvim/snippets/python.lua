---@diagnostic disable: undefined-global
local ts = require("vim.treesitter")

local function is_inside_init()
	local pos = vim.api.nvim_win_get_cursor(0)
	local bufnr = vim.api.nvim_get_current_buf()
	local row, col = pos[1] - 1, pos[2] - 1
	local node = ts.get_node({
		pos = { row, col },
	})

	while node do
		if node:type() == "function_definition" then
			local function_name_node = node:child(1)
			local function_name = ts.get_node_text(function_name_node, bufnr)
			if function_name == "__init__" then
				return true
			end
		end
		node = node:parent()
	end
	return false
end

return {
	s(",p", fmt("{1}={2}, ", { i(1, "param"), i(2, "None") })),
}, {
	s({ trig = "self.", condition = is_inside_init }, fmt("self.{1} = {1}", i(1, "arg"), { repeat_duplicates = true })),
}
