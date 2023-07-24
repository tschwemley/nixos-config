require('toggleterm').setup({open_mapping = [[<C-\>]]})

require('which-key').register({
	t = {
		name = 'Terminal',
		f = { '<cmd>ToggleTerm dir=float<cr>', 'Floating Terminal'},
		h = { '<cmd>ToggleTerm dir=horizontal<cr>', 'Horizontal Terminal'},
		t = { '<cmd>ToggleTerm dir=float<cr>', 'Terminal Tab'},
		v = { '<cmd>ToggleTerm dir=vertical<cr>', 'Vertical Terminal'},
	},
   { prefix = '<leader>', }
})
