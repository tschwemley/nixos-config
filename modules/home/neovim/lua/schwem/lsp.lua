local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
   'lua_ls',
   'gopls',
   'nil_ls', -- nix
   'sqlls',
   'tsserver',
   --'rust_analyzer',

   -- TODO: move these to the appropriate workspace(s) when time instead of ensuring globally
   'astro',
   'intelephense', -- php
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
   settings = {
      Lua = {
         diagnostics = {
            globals = { 'vim' }
         }
      }
   }
})

lsp.on_attach(function(client, bufnr)
   lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
