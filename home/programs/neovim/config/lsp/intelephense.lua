local get_intelephense_license = function()
	local f = assert(io.open("/run/secrets/intelephense_license", "rb"))
	local content = f:read("*a")
	f:close()
	return string.gsub(content, "%s+", "")
end

---@type vim.lsp.Config
return {
	init_options = { licenceKey = get_intelephense_license() },

	settings = { -- REF: https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
		intelephense = {
			format = { braces = "allman" },
			telemetry = { enabled = false },

			environment = {
				phpVersion = "8.2.23",
				shortOpenTag = true,
			},

			files = {
				maxSize = 1000000,

				exclude = {
					"**/.DS_Store/**",
					"**/.direnv/**",
					"**/.git/**",
					"**/.hg/**",
					"**/.history/**",
					"**/.svn/**",
					"**/CVS/**",
					"**/bower_components/**",
					"**/node_modules/**",
					"**/vendor/**/vendor/**",
					"**/vendor/**/{Tests,tests}/**",
					"/nix/store/**",
					"doc/scat/**",
				},
			},

			references = {
				exclude = {
					-- "**/.direnv/**",
					"/nix/store/**/*",
				},
			},
		},
	},
}
