local lsp = require('lsp-zero').preset({
   name = 'minimal',
   set_lsp_keymaps = true,
   manage_nvim_cmp = true,
   suggest_lsp_servers = false,
})
local set_keybinds = function()
   local whichKey = require('which-key')

   whichKey.register({
      l = {
         name = 'LSP',
         a = { '<cmd>Lspsaga code_action<cr>', 'Code Action', { buffer = true } },
         c = { '<cmd>Telescope lsp_document_symbols ignore_symbols=class,function,method,property,variable<cr>',
            'List Constants',
            { buffer = true } },
         r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename', { buffer = true } },
         R = { '<cmd>Telescope lsp_references<cr>', 'List References', { buffer = true } },
         m = { '<cmd>Telescope lsp_document_symbols ignore_symbols=constant,class,property,variable<cr>', 'List Methods',
            { buffer = true } },
         p = { '<cmd>Telescope lsp_document_symbols ignore_symbols=constant,class,function,method,variable<cr>',
            'List Properties',
            { buffer = true } },
         s = { '<cmd>Telescope lsp_document_symbols<cr>', 'List Symbols', { buffer = true } },
         v = { '<cmd>Telescope lsp_document_symbols ignore_symbols=constant,class,function,method,property<cr>',
            'List Variables',
            { buffer = true } },
      },
   }, { prefix = '<leader>' })

   whichKey.register({
      g = {
         name = 'Go To...',
         d = { vim.lsp.buf.definition, 'Go To Definition', { buffer = true } },
         D = { vim.lsp.buf.declaration, 'Go To Declaration', { buffer = true } },
      },
   })
end

lsp.on_attach(function(client, bufnr)
   lsp.default_keymaps({ buffer = bufnr })
   -- Don't autoformat for php
   if (client ~= 'intelephense')
   then
      lsp.buffer_autoformat()
   end

   set_keybinds()
end)

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
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

require('lspsaga').setup({})

vim.diagnostic.config({
   virtual_text = true,
})
