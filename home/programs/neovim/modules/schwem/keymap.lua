vim.g.mapleader = " ";
vim.keymap.set('i', 'jk', '<Esc>', {noremap = true})

vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true })

vim.keymap.set('n', '<leader>bb', '<cmd>BufferLineCyclePrev<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineCycleNext<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bmh', '<cmd>BufferLineMovePrev<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bml', '<cmd>BufferLineMoveNext<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bsd', '<cmd>BufferLineSortByDirectory<cr>', { noremap = true })
vim.keymap.set('n', '<leader>bsf', '<cmd>BufferLineSortByExtension<cr>', { noremap = true })

vim.keymap.set('n', '<leader>bd', ':bd<cr>', { noremap = true })
vim.keymap.set('n', '<leader>q', ':q<cr>', { noremap = true })
vim.keymap.set('n', '<leader>w', ':w<cr>', { noremap = true })
vim.keymap.set('n', '<leader>wq', ':wq<cr>', { noremap = true })

vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { noremap = true })
