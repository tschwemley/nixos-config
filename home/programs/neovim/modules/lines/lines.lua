local bufferline = require('bufferline')
local builtin = require('telescope.builtin')

require('lualine').setup()
bufferline.setup()

vim.keymap.set('n', '<leader>bch', '<cmd>BufferLineCloseLeft<cr>')
vim.keymap.set('n', '<leader>bcl', '<cmd>BufferLineCloseRight<cr>')
vim.keymap.set('n', '<leader>bcl', '<cmd>BufferLineCloseOthers<cr>')

vim.keymap.set('n', '<leader>bf', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>bj', bufferline.pick)
vim.keymap.set('n', '<leader>bt', builtin.current_buffer_tags)
