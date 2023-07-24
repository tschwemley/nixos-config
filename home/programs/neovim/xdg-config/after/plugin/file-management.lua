local wk = require('which-key')

require('bufferline').setup()
require('lualine').setup()

wk.register({
   b = {
      name = 'Buffers...',
      b = {':bp<cr>', 'Previous Buffer (back)'},
      d = {':bd<cr>', 'Delete Buffer'},
      j = {':BufferLinePick<cr>', 'Jump to a Buffer'},
      l = {':Telescope buffers<cr>', 'List Buffers (Telescope)'},
      n = {':bp<cr>', 'Next Buffer'},
   },
   c = {':close<cr>', 'Close File' },
   e = {'<cmd>NnnExplorer<cr>', 'Explore Files'},
   q = {':q!<cr>', 'Quit' },
   w = {':w!<cr>', 'Save File' },
}, { prefix = '<leader>' })
