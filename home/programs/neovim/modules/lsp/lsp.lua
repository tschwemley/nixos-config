local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

---------------------------------------------------------------------------------------------------
--- LSP
---------------------------------------------------------------------------------------------------
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

local servers = {
	"bashls",
	"gopls",
	"htmx",
	-- "intelephense",
	-- "lua_ls",
	"nil_ls",
	"sqls",
	"taplo", -- taplo is for toml
	"templ",
	"ts_ls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		autostart = true,
		capabilities = capabilities, -- this adds nvim-cmp capabilities to each lsp server in list
	})
end

-- TODO: the servers below here should be handled the same as other servers once migrated fully to defining settings
-- in the ./servers directory
lspconfig.intelephense.setup({
	autostart = true,
	capabilities = capabilities,
	settings = {
		intelephense = {
			files = {
				exclude = {
					"**/.git/**",
					"**/.svn/**",
					"**/.hg/**",
					"**/CVS/**",
					"**/.DS_Store/**",
					"**/node_modules/**",
					"**/bower_components/**",
					"**/vendor/**/{Tests,tests}/**",
					"**/.history/**",
					"**/vendor/**/vendor/**",
					"/nix/store/**",
				},
			},
		},
	},
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			autostart = true,
			capabilities = capabilities,
			runtime = { version = "Lua 5.1" },
			diagnostics = {
				globals = { "vim", "it", "describe", "before_each", "after_each" },
			},
		},
	},
})
