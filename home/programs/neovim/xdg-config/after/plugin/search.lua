local wk = require('which-key')

wk.register({
	f = {'<cmd>Telescope find_files<cr>', 'Find Files',},
	s = {
		name = 'Search...',
		b = {'<cmd>Telescope buffers<cr>', 'Search Buffers',},
		k = {'<cmd>Telescope keymaps<cr>', 'Search Keybindings',},
		t = {'<cmd>Telescope live_grep<cr>', 'Search Text',},
		w = {'<cmd>Telescope grep_string<cr>', 'Search Word Under Cursor'},
	},
}, {prefix = '<leader>'})
