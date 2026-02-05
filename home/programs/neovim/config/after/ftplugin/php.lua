require("helpers").set_tabs(4)

vim.lsp.enable("intelephense")
vim.treesitter.start()

vim.bo.commentstring = "// %s"
