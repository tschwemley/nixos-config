local lsp = require('lsp-zero').preset({})
local whichKey = require('which-key')

lsp.on_attach(function(client, bufnr)
   lsp.default_keymaps({ buffer = bufnr })
   lsp.buffer_autoformat()

   whichKey.register({
      g = {
         name = 'Go To...',
         d = { vim.lsp.buf.definition, 'Go To Definition', { buffer = true } },
         D = { vim.lsp.buf.declaration, 'Go To Declaration', { buffer = true } },
      },
   })

   whichKey.register({
      l = {
         name = 'LSP',
         c = { '<cmd>Telescope lsp_symbols ignore_symbol=class,function,method,property,variable<cr>', 'List Constants',
            { buffer = true } },
         r = { '<cmd>Telescope lsp_references<cr>', 'List References', { buffer = true } },
         m = { '<cmd>Telescope lsp_symbols ignore_symbol=constant,class,property,variable<cr>', 'List Methods',
            { buffer = true } },
         p = { '<cmd>Telescope lsp_symbols ignore_symbol=constant,class,function,method,variable<cr>', 'List Properties',
            { buffer = true } },
         s = { '<cmd>Telescope lsp_symbols<cr>', 'List Symbols', { buffer = true } },
         v = { '<cmd>Telescope lsp_symbols ignore_symbol=constant,class,function,method,property<cr>',
            'List Variables',
            { buffer = true } },
      },
   }, { prfeix = '<leader>' })
end)

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
-- TODO: remove this after testing different nix servers
lsp.setup_servers({ 'gopls', 'intelephense', 'lua_ls', 'tsserver', 'yamlls' })

require('lsp-zero').configure('nil_ls', {
   settings = {
      ['nil'] = {
         formatting = {
            command = { 'alejandra' },
         },
      },
   },
})

lsp.setup()
