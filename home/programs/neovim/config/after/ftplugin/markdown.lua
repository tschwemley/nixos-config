require("helpers").set_tabs(4)

require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
})

vim.lsp.enable("marksman")
vim.treesitter.start()
