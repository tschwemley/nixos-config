require("helpers").set_tabs(4)

vim.bo.commentstring = "// %s"

vim.lsp.enable("intelephense")

vim.opt_local.foldenable = true
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
