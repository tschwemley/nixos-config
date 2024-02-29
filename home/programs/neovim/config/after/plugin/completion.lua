local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local has_words_before = function()
   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- Completion config
cmp.setup({
   sources = {
      { name = 'buffer' },
      { name = 'emoji' },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
   },
   mapping = {
      ["<Tab>"] = vim.schedule_wrap(function(fallback)
         if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
         else
            fallback()
         end
      end),
      ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
         if cmp.visible() and has_words_before() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
         else
            fallback()
         end
      end),
   },
   -- mapping = cmp.mapping.preset.insert({
   --    ['<Tab>'] = cmp_action.luasnip_supertab(),
   --    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
   -- })
})
