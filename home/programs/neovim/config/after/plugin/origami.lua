vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.wo.foldenable = true
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

require("origami").setup()
