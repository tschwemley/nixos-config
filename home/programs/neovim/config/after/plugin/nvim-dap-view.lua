require("dap-view").setup({
	winbar = {
		default_section = "scopes",

		controls = {
			enabled = true,
		},
	},

	auto_toggle = true,

	-- Reopen dapview when switching to a different tab
	-- Can also be a function to dynamically choose when to follow, by returning a boolean
	-- If a function, receives the name of the adapter for the current session as an argument
	follow_tab = false,
})
