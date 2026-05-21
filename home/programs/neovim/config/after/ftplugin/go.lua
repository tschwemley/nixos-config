vim.lsp.enable("gopls")
vim.treesitter.start()

require("dap-go").setup()

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
