local copilot = require("copilot")
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
-- require('luasnip')

vim.api.nvim_create_autocmd("InsertEnter", {
   callback = function()
      require('copilot').setup({
         -- diabled on recommendation of coilot-cmp see: https://github.com/zbirenbaum/copilot-cmp/
         suggestion = { enabled = false },
         panel = { enabled = false },
      })
   end
})

require('luasnip.loaders.from_vscode').lazy_load()

-- Completion config
cmp.setup({
   sources = {
      { name = 'buffer' },
      { name = 'copilot' },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
   },
   mapping = {
      -- enable super tab
      ['<Tab>'] = cmp_action.luasnip_supertab(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
   },
})
