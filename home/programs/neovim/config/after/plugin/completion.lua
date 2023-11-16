local copilot = require("copilot")
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local ls = require('luasnip')

vim.api.nvim_create_autocmd("InsertEnter", {
   callback = function()
      require('copilot').setup({
         -- diabled on recommendation of coilot-cmp see: https://github.com/zbirenbaum/copilot-cmp/
         suggestion = { enabled = false },
         panel = { enabled = false },
      })
   end
})

-- Completion config
cmp.setup({
   mapping = {
      -- enable super tab
      ['<Tab>'] = cmp_action.luasnip_supertab(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
   },

   sources = {
      { name = 'buffer',  group_index = 3 },
      { name = 'copilot', group_index = 2 },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
   },
})

-- Snippet config
require('luasnip.loaders.from_vscode').lazy_load({})
