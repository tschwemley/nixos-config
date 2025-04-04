return {
	-- New module function
	s(
		"mfn",
		c(1, {
			fmt("function {}.{}({})\n  {}\nend", {
				f(get_returned_mod_name, {}),
				i(1),
				i(2),
				i(3),
			}),
			fmt("function {}:{}({})\n  {}\nend", {
				f(get_returned_mod_name, {}),
				i(1),
				i(2),
				i(3),
			}),
		})
	),
}
