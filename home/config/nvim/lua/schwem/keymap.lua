local wk = require("which-key")

local lspKeybinds = {
	name = "LSP",
	d = { "<cmd>Telescope lsp_definitions<cr>", "Find Definitions" },
	i = { "<cmd>Telescope lsp_implementations<cr>", "Find Implementations" },
	r = { "<cmd>Telescope lsp_references<cr>", "Find References" }
}

local searchKeybinds = {
	name = "Search",
	f = { "<cmd>Telescope find_files<cr>", "Search Files" },
	t = { "<cmd>Telescope live_grep<cr>", "Search Text" },
	w = { "<cmd>Telescope grep_string<cr>", "Find Visual/Word Under Cursor" }
}


-- <leader>* keybindings:
wk.register({
	["<leader>"] = { 
		e = { "<cmd>NnnExplorer<cr>", "Explore Files" },
		f = { "<cmd>Telescope find_files<cr>", "Search Files" },
		s = searchKeybinds,	
		l = lspKeybinds,
		w = { ":w!<cr>", "Save" },
	},
}, { mode = "n" })

-- 
-- TERMINAL MODE
--
wk.register({
	["<leader>"] = { 
		e = { "<cmd>NnnExplorer<cr>", "Explore Files" },
	},
}, { mode = "t" })
