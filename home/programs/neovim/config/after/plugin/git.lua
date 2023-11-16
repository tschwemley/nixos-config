local neogit = require('neogit')

require('gitsigns').setup()
neogit.setup()

require('which-key').register({ {
   g = { name = 'Git', { '<cmd>Neogit<cr>', '', { buffer = true } }, },
},
   { prefix = '<leader>' }
})
