local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
   lsp.default_keymaps({ buffer = bufnr })
   lsp.buffer_autoformat()
end)

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
-- TODO: remove this after testing different nix servers
lsp.setup_servers({ 'gopls', 'intelephense', 'lua_ls', 'tsserver', 'yamlls' })

require('lspzero').configure('nil_ls', {
   settings = {
      ['nil'] = {
         formatting = {
            command = { 'alejandra' },
         },
      },
   },
})

lsp.setup()
