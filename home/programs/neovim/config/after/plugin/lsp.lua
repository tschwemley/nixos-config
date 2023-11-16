local lsp = require('lsp-zero').preset({
   name = 'minimal',
   set_lsp_keymaps = true,
   manage_nvim_cmp = true,
   suggest_lsp_servers = false,
})
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

   -- Format on save (changed lines only)
   local augroup_id = vim.api.nvim_create_augroup(
      "FormatModificationsDocumentFormattingGroup",
      { clear = false }
   )
   vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

   vim.api.nvim_create_autocmd(
      { "BufWritePre" },
      {
         group = augroup_id,
         buffer = bufnr,
         callback = function()
            local lsp_format_modifications = require "lsp-format-modifications"
            lsp_format_modifications.format_modifications(client, bufnr)
         end,
      }
   )
end)

whichKey.register({
   l = {
      name = 'LSP',
      c = { '<cmd>Telescope lsp_document_symbols ignore_symbols=class,function,method,property,variable<cr>',
         'List Constants',
         { buffer = true } },
      -- r = { '<cmd>lua vim.lua.lsp.buf.rename<cr>', 'Rename', { buffer = true } },
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

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
-- lsp.setup_servers({ 'astro', 'gopls', 'intelephense', 'lua_ls', 'tsserver', 'yamlls' })
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

vim.diagnostic.config({
   virtual_text = true,
})
