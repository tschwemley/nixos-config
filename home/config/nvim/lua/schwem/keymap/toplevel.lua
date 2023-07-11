local wk = require('which-key')

wk.register({
	e = {"<cmd>NnnExplorer:<cr>", "File Explorer", noremap = true }
	f = {"<cmd>Telescope find_files<cr>", "Find Files", noremap=true, },
	q = {":q!", "Quit", noremap=true, },
	w = {":w!", "Save File", noremap=true, },
})
