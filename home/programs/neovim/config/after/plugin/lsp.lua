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

-- TODO: not sure I like this plugin - documentation is lacking and customisability isn't to the
-- level that I would like it to be
require('lspsaga').setup({
   lightbulb = {
      enable_in_insert = false
   },
})

vim.diagnostic.config({
   virtual_text = true,
})

-- yaml companion
-- TODO: move this out somewhere else
local yaml_companion_cfg = require("yaml-companion").setup({})
local lspconfig = require("lspconfig")
lspconfig["yamlls"].setup(yaml_companion_cfg)
lspconfig.haxe_language_server.setup({
   cmd = { "node", "/home/schwem/.config/language-servers/haxe-server.js" },
   init_options = {
      displayArguments = { "build.hxml" }
   },
})
require("telescope").load_extension("yaml_schema")
