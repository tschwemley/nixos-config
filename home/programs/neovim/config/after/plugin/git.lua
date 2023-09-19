local neogit = require('neogit')

require('gitsigns').setup()
neogit.setup()

require('which-key').register({
   g = { neogit.open(), 'Open Neogit', { prefix = '<leader>' } }
})
