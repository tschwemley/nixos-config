vim.g.mapleader = " ";
vim.keymap.set('i', 'jk', '<Esc>', {noremap = true})

vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true })

vim.keymap.set('n', '<leader>bb', ':bp<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bd', ':bd<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bn', ':bn<cr>', { noremap = true })
vim.keymap.set('n', '<leader>q', ':q<cr>', { noremap = true })
vim.keymap.set('n', '<leader>w', ':w<cr>', { noremap = true })
vim.keymap.set('n', '<leader>wq', ':wq<cr>', { noremap = true })
