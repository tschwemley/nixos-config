require('schwem.helpers').set_tabs(2)

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
   pattern = { '*.nix' },
   command = ':%!alejandra -qq'
})
