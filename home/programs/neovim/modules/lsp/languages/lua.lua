require('lspconfig').lua_ls.setup {
   capabilities = capabilities,
   settings = {
      Lua = {
         runtime = { version = "Lua 5.1" },
         diagnostics = {
            globals = { "vim", "it", "describe", "before_each", "after_each" },
         }
      }
   }
}
