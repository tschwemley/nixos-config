local wk = require("which-key")

-- 
-- NORMAL MODE
--

-- <leader>* keybindings:
wk.register({
	"<leader>" = { 
		e = { "<cmd>NnnExplorer<cr>", "Explore Files" },

		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<cr>", "Find Files" },
			t = { "<cmd>Telescope live_grep<cr>", "Find Implementations" },
			w = { "<cmd>Telescope grep_string<cr>", "Find Visual/Word Under Cursor" }
		},

		l = {
			name = "LSP",
			d = { "<cmd>Telescope lsp_definitions<cr>", "Find Definitions" },
			i = { "<cmd>Telescope lsp_implementations<cr>", "Find Implementations" },
			r = { "<cmd>Telescope lsp_references<cr>", "Find References" }
		},

		w = { ":w!<cr>", "Save" },
	},
}, { mode = "n" })

-- 
-- TERMINAL MODE
--



-- Ctrl-* keybindings:

--
-- see: :h which-key - OR - https://github.com/folke/which-key.nvim
-- 
