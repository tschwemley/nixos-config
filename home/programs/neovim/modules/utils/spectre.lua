local spectre = require('spectre')
spectre.setup({
   use_trouble_qf = true,
})

vim.keymap.set('n', '<leader>S', spectre.toggle, {
    desc = "Toggle Spectre"
})

vim.keymap.set('n', '<leader>sr', spectre.toggle, {
    desc = "Toggle Spectre"
})
