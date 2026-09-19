local augend = require("dial.augend")

-- REF: https://github.com/monaqa/dial.nvim/#configuration
require("dial.config").augends:register_group({
	default = {
		augend.constant.alias.bool, -- true <-> false
		augend.constant.alias.Bool, -- True <-> False

		augend.integer.alias.decimal,
		augend.integer.alias.decimal_int,

		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%m/%d"],
		augend.date.alias["%H:%M"],
	},
})

vim.keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end)

vim.keymap.set("n", "<C-x>", function()
	require("dial.map").manipulate("decrement", "normal")
end)

vim.keymap.set("x", "<C-a>", function()
	require("dial.map").manipulate("increment", "visual")
end)

vim.keymap.set("x", "<C-x>", function()
	require("dial.map").manipulate("decrement", "visual")
end)
