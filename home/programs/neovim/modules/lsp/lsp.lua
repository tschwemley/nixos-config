local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

---------------------------------------------------------------------------------------------------
--- LSP
---------------------------------------------------------------------------------------------------
local capabilities =
    vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

local servers = { "bashls", "dprint", "gopls", "intelephense", "lua_ls", "nil_ls", "sqls", "templ", "tsserver" }
for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup({
      capabilities = capabilities, -- this adds nvim-cmp capabilities to each lsp server in list
   })
end

-- TODO: clean this up so the servers that need additional config are handled in a more robust way
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
