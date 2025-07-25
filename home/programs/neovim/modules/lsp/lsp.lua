-- local blink = require("blink.cmp")
-- local lspconfig = require("lspconfig")

---------------------------------------------------------------------------------------------------
--- LSP
---------------------------------------------------------------------------------------------------
-- local servers = {
vim.lsp.enable({
   "bashls",
   "gopls",
   -- "intelephense",
   "lua_ls",
   "marksman",
   "nil_ls", -- TODO: choose one of either nixd or nil_ls for nix lsp
   -- "phpactor",
   "sqls",
   "taplo", -- taplo is for toml
   "templ",
   "ts_ls",
   "yamlls",
}

-- local defaultConfig = {
--    autostart = true,
--    capabilities = vim.tbl_deep_extend(
--       "force",
--       vim.lsp.protocol.make_client_capabilities(),
--       blink.get_lsp_capabilities(),
--       -- File watching is disabled by default for neovim.
--       -- See: https://github.com/neovim/neovim/pull/22405
--       { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
--    ),
-- }
--
-- for _, server in ipairs(servers) do
--    local config = defaultConfig
--
--    -- Check if a configuration file exists for the current LSP server
--    local configPath = vim.fn.stdpath("config") .. "/lua/lspconfigs/" .. server .. ".lua"
--    if vim.uv.fs_stat(configPath) then
--       config = vim.tbl_deep_extend("force", config, require("lspconfigs." .. server))
--    end
--
--    -- Set up the LSP server with the merged config
--    lspconfig[server].setup(config)
-- end
