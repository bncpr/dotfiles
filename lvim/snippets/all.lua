---@diagnostic disable: undefined-global
return {
	s("qmkcomb", fmt("COMB({1}, {2}, {3})", { i(1, "name"), i(2, "result"), i(3, "combo") })),
	s(
		"qmksubs",
		fmt('SUBS({1}, "{2}"{3}, {4})', { i(1, "name"), i(2, "result"), i(3, "rest of string"), i(4, "combo") })
	),
}
