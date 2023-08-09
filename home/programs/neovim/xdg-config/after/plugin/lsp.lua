local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
lsp.setup_servers({'gopls', 'intelephense', 'lua_ls', 'nixd', 'tsserver', 'toml', 'yamlls'})

lsp.setup()
