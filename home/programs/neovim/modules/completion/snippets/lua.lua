local helpers = require("./helpers")

local c = helpers.c
local i = helpers.i
local s = helpers.s

local fmt = helpers.fmt

-- Snippet Definitions
-- ===================

local module_function = s(
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
)

return {
	module_function,
}
