require('toggleterm').setup({open_mapping = [[c-\]]})

require('which-key').register({
	t = {
		name = 'Terminal',
      prefix = '<leader>',
		f = { '<cmd>ToggleTerm dir=float<cr>', 'Floating Terminal'},
		h = { '<cmd>ToggleTerm dir=horizontal<cr>', 'Horizontal Terminal'},
		t = { '<cmd>ToggleTerm dir=float<cr>', 'Terminal Tab'},
		v = { '<cmd>ToggleTerm dir=vertical<cr>', 'Vertical Terminal'},
	},
   {
      [[<C-\>]] = { '<cmd>ToggleTerm dir=float<cr>', 'Floating Terminal'},
   },
})
