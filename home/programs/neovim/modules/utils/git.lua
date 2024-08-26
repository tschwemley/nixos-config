local neogit = require('neogit')

require('gitsigns').setup()
neogit.setup {}

vim.keymap.set('n', '<leader>g', neogit.open, { noremap = true })
vim.keymap.set('n', '<leader>gc', '<cmd>Neogit commit<cr>', { noremap = true })
