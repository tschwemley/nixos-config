require("helpers").set_tabs(4)

vim.bo.commentstring = "// %s"

-- TODO: decide which lsp to use
vim.lsp.enable("intelephense")
-- vim.lsp.enable("phpactor")

vim.opt_local.foldenable = true
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
