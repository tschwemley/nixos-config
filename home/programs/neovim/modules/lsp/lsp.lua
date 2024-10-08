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
   "intelephense",
   "lua_ls",
   "nil_ls",
   "sqls",
   "taplo",
   "templ",
   "tsserver",
}

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup({
      autostart = true,
      capabilities = capabilities, -- this adds nvim-cmp capabilities to each lsp server in list
   })
end

lspconfig.lua_ls.setup({
   capabilities = capabilities,
   settings = {
      Lua = {
         runtime = { version = "Lua 5.1" },
         diagnostics = {
            globals = { "vim", "it", "describe", "before_each", "after_each" },
         },
      },
   },
})
