require("neorg").setup({
	load = {
		["core.defaults"] = {
			config = {
				disable = {
					-- module list goes here
					"core.autocommands",
					"core.itero",
				},
			},
		},
		-- ["core.completion"] = {
		-- 	config = {
		-- 		engine = "nvim-cmp",
		-- 	},
		-- },
		["core.concealer"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
				index = "index.norg",
			},
		},
		["core.integrations.telescope"] = {},
		["core.ui"] = {},
		["core.ui.calendar"] = {},
	},
})
