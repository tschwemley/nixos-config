-- REF: https://cmp.saghen.dev/configuration/general.html
require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	signature = { enabled = true }, -- signature.window.show_documentation = false to only show the signature, and not the documentation
	snippets = { preset = "luasnip" },

	-- -- use mini.icons in the completion menu
	-- completion = {
	--    menu = {
	--       draw = {
	--          components = {
	--             kind_icon = {
	--                text = function(ctx)
	--                   local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
	--                   return kind_icon
	--                end,
	--                -- (optional) use highlights from mini.icons
	--                highlight = function(ctx)
	--                   local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
	--                   return hl
	--                end,
	--             },
	--             kind = {
	--                -- (optional) use highlights from mini.icons
	--                highlight = function(ctx)
	--                   local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
	--                   return hl
	--                end,
	--             },
	--          },
	--       },
	--    },
	-- },

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
