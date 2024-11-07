local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

---------------------------------------------------------------------------------------------------
--- LSP
---------------------------------------------------------------------------------------------------
local defaultConfig = {
	autostart = true,
	-- this adds nvim-cmp capabilities to each lsp server in list
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		cmp_lsp.default_capabilities()
	),
}

local servers = {
	"bashls",
	"gopls",
	"htmx",
	"intelephense",
	"lua_ls",
	"marksman",
	"nil_ls",
	"sqls",
	"taplo", -- taplo is for toml
	"ts_ls",
	"yamlls",
}

for _, lsp in ipairs(servers) do
	local config = defaultConfig

	-- Check if a configuration file exists for the current LSP server
	local configPath = vim.fn.stdpath("config") .. "/lua/lspconfigs/" .. lsp .. ".lua"
	if vim.uv.fs_stat(configPath) then
		-- Load the settings from the configuration file and merge them into the default setup options
		config = vim.tbl_deep_extend("force", config, require("lspconfigs." .. lsp))
	end

	-- Set up the LSP server with the merged config
	lspconfig[lsp].setup(config)
end
