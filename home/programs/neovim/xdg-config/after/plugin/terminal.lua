require('toggleterm').setup({
   direction = 'vertical',
   open_mapping = [[<C-\>]],
})

require('which-key').register({
	t = {
		name = 'Terminal',
		f = { '<cmd>ToggleTerm direction=float<cr>', 'Floating Terminal'},
		h = { '<cmd>ToggleTerm direction=horizontal<cr>', 'Horizontal Terminal'},
		t = { '<cmd>ToggleTerm direction=float<cr>', 'Terminal Tab'},
		v = { '<cmd>ToggleTerm direction=vertical<cr>', 'Vertical Terminal'},
	},
   { prefix = '<leader>', }
})
