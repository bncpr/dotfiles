---@diagnostic disable: undefined-global
return {}, {
	s("return", fmt("return {1};", { i(1) }), { condition = conds.line_begin }),
}
