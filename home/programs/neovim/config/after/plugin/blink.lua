-- REF: https://github.com/xzbdmw/colorful-menu.nvim
require("colorful-menu").setup({})

-- REF: https://cmp.saghen.dev/configuration/general.html
require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	signature = { enabled = true }, -- signature.window.show_documentation = false to only show the signature, and not the documentation
	snippets = { preset = "luasnip" },

	completion = {
		menu = {
			draw = {
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
	},

	sources = {
		default = { "buffer", "emoji", "lsp", "path", "snippets" },

		per_filetype = {
			gitcommit = { "conventional_commits", "snippets" },
			lua = { "buffer", "lazydev", "lsp", "snippets" },
			mysql = { "buffer", "dadbod", "lsp", "path", "snippets" },
			sql = { "buffer", "dadbod", "lsp", "path", "snippets" },
		},

		providers = {
			css_vars = { name = "css-vars", module = "css-vars.blink" },
			conventional_commits = { name = "Conventional Commits", module = "blink-cmp-conventional-commits" },
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			env = { name = "Env", module = "blink-cmp-env" },
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },

			-- TODO: remove this is per_filetype works with above provider def
			-- conventional_commits = {
			-- 	name = "Conventional Commits",
			-- 	module = "blink-cmp-conventional-commits",
			-- 	enabled = function()
			-- 		return vim.bo.filetype == "gitcommit"
			-- 	end,
			-- 	opts = {},
			-- },

			emoji = {
				name = "Emoji",
				module = "blink-emoji",
				-- Enable emoji completion only for git commits and markdown.
				should_show_items = function()
					return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
				end,
			},
		},
	},
})
