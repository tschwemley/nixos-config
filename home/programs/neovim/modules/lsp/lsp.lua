local blink = require("blink.cmp")
-- local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local log = require("plenary.log")
-- local log = require("plenary.log").new()

---------------------------------------------------------------------------------------------------
--- LSP
---------------------------------------------------------------------------------------------------
-- local defaultConfig = {
-- 	autostart = true,
-- 	-- this adds nvim-cmp capabilities to each lsp server in list
-- 	capabilities = vim.tbl_deep_extend(
-- 	   "force",
-- 	   {},
-- 	   vim.lsp.protocol.make_client_capabilities(),
-- 	   cmp_lsp.default_capabilities()
-- 	),
-- }

local servers = {
	"bashls",
	"gopls",
	"intelephense",
	"lua_ls",
	"marksman",
	"nil_ls",
	"sqls",
	"taplo", -- taplo is for toml
	"ts_ls",
	"yamlls",
}

for _, server in ipairs(servers) do
	log.info("Setting up LSP config for: ", server)
	print("Setting up LSP config for: ", server)
	local config = {
		autostart = true,
		capabilities = vim.lsp.protocol.make_client_capabilities(),
		-- capabilities = blink.get_lsp_capabilities(_, true),
	}

	log.fmt_info("\tconfig: %s\n", config)

	-- Check if a configuration file exists for the current LSP server
	local configPath = vim.fn.stdpath("config") .. "/lua/lspconfigs/" .. server .. ".lua"
	if vim.uv.fs_stat(configPath) then
		config = vim.tbl_deep_extend("force", config, require("lspconfigs." .. server))
		log.fmt_info("\t**Aditional config defined for: %s at %s\n\tmerged config: %s\n", server, configPath, config)
	end

	-- Set up the LSP server with the merged config
	lspconfig[server].setup(config)
end
