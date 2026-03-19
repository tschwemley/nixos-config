require("helpers").set_tabs(4)

require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
	latex = { enabled = false },
})

vim.lsp.enable("marksman")
vim.treesitter.start()
