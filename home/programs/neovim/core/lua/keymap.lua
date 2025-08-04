vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

vim.keymap.set("n", "<leader>bd", ":bd<cr>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w!<cr>", { noremap = true, silent = true })

vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true })
