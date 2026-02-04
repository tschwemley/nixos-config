require("todo-comments").setup({
	colors = {
		default = { "Identifier", "#7daea3" },
		error = { "DiagnosticError", "ErrorMsg", "#ea6962" },
		hint = { "DiagnosticHint", "#89b482" },
		info = { "DiagnosticInfo", "#7daea3" },
		ok = { "DiagnosticOk", "#a9b665" },
		test = { "Identifier", "#FF00FF" },
		warning = { "DiagnosticWarn", "WarningMsg", "#d8a657" },
	},

	keywords = {
		REF = {
			icon = "",
			color = "info",
			alt = { "DOCS", "DOC", "DOCUMENTATION", "REFERENCE", "LINK", "LINKS" },
		},

		NOTE = { color = "warning" },

		TODO = { icon = " ", color = "info" },

		UPSTREAM = {
			icon = "󰞍",
			color = "hint",
		},
	},
})
