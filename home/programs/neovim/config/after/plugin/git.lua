local neogit = require('neogit')

require('gitsigns').setup()
neogit.setup()

require('which-key').register({
   g = { '<cmd>Neogit<cr>', 'Open Neogit', { prefix = '<leader>' } }
})
