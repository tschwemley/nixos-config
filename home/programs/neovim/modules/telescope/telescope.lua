local builtin = require('telescope.builtin')

-- [f]ind
vim.keymap.set('n', '<leader>f', builtin.find_files)

-- [s]earch commands
vim.keymap.set('n', '<leader>sc', builtin.commands)
vim.keymap.set('n', '<leader>sf', builtin.find_files)
vim.keymap.set('n', '<leader>sh', builtin.help_tags)
vim.keymap.set('n', '<leader>sk', builtin.keymaps)
vim.keymap.set('n', '<leader>st', builtin.live_grep)
vim.keymap.set('n', '<leader>sw', builtin.grep_string)

-- misc. commands
vim.keymap.set('n', '<leader>bl', builtin.buffers)
