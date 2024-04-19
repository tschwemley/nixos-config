local dap = require('dap')

require('dap-go').setup()

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>dr', dap.repl.toggle)
vim.keymap.set('n', '<leader>di', dap.step_into)
