require("helpers").set_tabs(4)

vim.lsp.enable("intelephense")
vim.treesitter.start()

vim.bo.commentstring = "// %s"

-- TODO: uncomment this if issues with syntax highlighting
-- vim.bo.syntax = "ON"
