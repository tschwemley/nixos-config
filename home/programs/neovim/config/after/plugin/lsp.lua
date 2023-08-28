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
         r = { '<cmd>Telescope lsp_references<cr>', 'List References', { buffer = true } },
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
