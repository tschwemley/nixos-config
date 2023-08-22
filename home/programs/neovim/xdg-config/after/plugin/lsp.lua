local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
   lsp.default_keymaps({ buffer = bufnr })
   lsp.buffer_autoformat()
end)

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
-- TODO: remove this after testing different nix servers
local nixServer = 'nixd' -- nil_ls cmd not found (see if same problem w/ nixd)
lsp.setup_servers({ 'gopls', 'intelephense', 'lua_ls', nixServer, 'tsserver', 'yamlls' })

lsp.setup()
