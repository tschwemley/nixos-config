require("helpers").set_tabs(4, false)

require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
	latex = { enabled = false },
})

-- TODO: this requires a workspace for proper setup. Probably should be defined in project local
-- config @ .nvim.lua
-- require("obsidian").setup({
-- 	picker = {
-- 		name = "telescope.nvim",
-- 	},
-- })

vim.lsp.enable("marksman")
vim.treesitter.start()
