vim.lsp.enable("gopls")

vim.treesitter.start()
-- folds, provided by Neovim
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldmethod = "expr"
-- indentation, provided by nvim-treesitter
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
