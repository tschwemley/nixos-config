require("helpers").set_tabs(4)

require("render-markdown").setup({})

vim.lsp.enable("marksman")
vim.treesitter.start()
