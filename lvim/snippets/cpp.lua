---@diagnostic disable: undefined-global
return {}, {
	s(
		"} else",
		fmt(
			[[
      }} else {{
          {1}
      }}
    ]],
			i(1)
		),
		{ condition = conds.line_begin + conds.line_end }
	),
	s("return", fmt("return {1};", { i(1) }), { condition = conds.line_begin }),
	s(
		"if",
		fmt(
			[[
      if ({1})
      {{
          {2}
      }}
    ]],
			{ i(1), i(2) }
		),
		{ condition = conds.line_begin }
	),
	s(
		{ trig = "(%w+):", regTrig = true },
		f(function(_, snip)
			return snip.trigger .. ":"
		end, {})
	),
}
