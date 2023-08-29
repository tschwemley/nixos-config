local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local ls = require('luasnip')

-- Copilot config
use {
   "zbirenbaum/copilot.lua",
   cmd = "Copilot",
   event = "InsertEnter",
   config = function()
      require("copilot").setup({
         suggestion = { enabled = false },
         panel = { enabled = false },
      })
   end,
}

-- Completion config
cmp.setup({
   mapping = {
      -- enable super tab
      ['<Tab>'] = cmp_action.luasnip_supertab(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
   },

   sources = {
      { name = 'buffer',  group_index = 3 },
      { name = "copilot", group_index = 2 },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
   },
})

-- Snippet config
ls.loaders.from_vscode.lazy_load({})
