local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	mapping = {
		-- enable super tab
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
	},
})
