local wk = require('which-key')

require('bufferline').setup()
require('lualine').setup()
-- require('ufo').setup()

wk.register({
   b = {
      name = 'Buffers...',
      b = { ':bp<cr>', 'Previous Buffer (back)' },
      d = { ':bd<cr>', 'Delete Buffer' },
      j = { ':BufferLinePick<cr>', 'Jump to a Buffer' },
      l = { ':Telescope buffers<cr>', 'List Buffers (Telescope)' },
      n = { ':bn<cr>', 'Next Buffer' },
   },
   c = { ':close<cr>', 'Close File' },
   e = { '<cmd>NnnExplorer %:p:h<cr>', 'Explore Files' },
   q = { ':q!<cr>', 'Quit' },
   w = { ':w!<cr>', 'Save File' },
}, { prefix = '<leader>' })
