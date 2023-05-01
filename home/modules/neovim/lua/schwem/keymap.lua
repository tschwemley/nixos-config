local wk = require("which-key")

-- Completion
wk.register({
	l = {
		name = "LSP",
		d = { "<cmd>Telescope lsp_definition<cr>", "Go To/Show Definition(s)" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "Go To/Show Implementation(s)" },
		r = { "<cmd>Telescope lsp_references<cr>", "List References" },
	},
}, { prefix = "<leader>" })

--
-- see: :h which-key - or - https://github.com/folke/which-key.nvim
-- 
