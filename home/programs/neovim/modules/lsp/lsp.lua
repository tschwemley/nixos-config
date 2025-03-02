-- TODO: clean up commented testing code when done
--
local blink = require("blink.cmp")
local log = require("plenary.log")
local lspconfig = require("lspconfig")
-- local log = require("plenary.log").new()

---------------------------------------------------------------------------------------------------
--- LSP
---------------------------------------------------------------------------------------------------
local servers = {
   "bashls",
   "gopls",
   -- "intelephense", -- TODO: decide if keeping intelephense or phpactor
   "lua_ls",
   "marksman",
   "nil_ls", -- TODO: choose one of either nixd or nil_ls for nix lsp
   "phpactor", -- TODO: decide if keeping intelephense or phpactor
   "sqls",
   "taplo",  -- taplo is for toml
   "templ",
   "ts_ls",
   "yamlls",
}

local defaultConfig = {
   autostart = true,
   capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      blink.get_lsp_capabilities()
   ),
   -- capabilities = vim.lsp.protocol.make_client_capabilities(),
   -- capabilities = blink.get_lsp_capabilities(_, true),
}

for _, server in ipairs(servers) do
   local config = defaultConfig

   -- Check if a configuration file exists for the current LSP server
   local configPath = vim.fn.stdpath("config") .. "/lua/lspconfigs/" .. server .. ".lua"
   if vim.uv.fs_stat(configPath) then
      config = vim.tbl_deep_extend("force", config, require("lspconfigs." .. server))
   end

   -- Set up the LSP server with the merged config
   lspconfig[server].setup(config)
end
