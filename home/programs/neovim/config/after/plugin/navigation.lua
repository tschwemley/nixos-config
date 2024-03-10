local ufo = require('ufo');
local wk = require('which-key')

require('bufferline').setup()
require('lualine').setup()

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

ufo.setup({
   provider_selector = function(bufnr, filetype, buftype)
      if filetype == 'norg' then
         return ''
      else
         return { 'treesitter', 'indent' }
      end
   end
})

wk.register({
   b = {
      name = 'Buffers...',
      H = { '<cmd>BufferLineMovePrev<cr>', 'Move Buffer Left' },
      L = { '<cmd>BufferLineMoveNext<cr>', 'Move Buffer Right' },
      b = { ':bp<cr>', 'Previous Buffer (back)' },
      c = {
         h = { '<cmd>BufferLineCloseLeft<cr>', 'Close Buffers to the Left' },
         l = { '<cmd>BufferLineCloseRight<cr>', 'Close Buffers to the Right' },
         o = { '<cmd>BufferLineCloseOthers<cr>', 'Close Other Buffers' },
      },
      d = { ':bd<cr>', 'Delete Buffer' },
      j = { ':BufferLinePick<cr>', 'Jump to a Buffer' },
      l = { ':Telescope buffers<cr>', 'List Buffers (Telescope)' },
      n = { ':bn<cr>', 'Next Buffer' },
   },
   c = { ':close<cr>', 'Close File' },
   e = { '<cmd>NnnPicker %:p:h<cr>', 'Explore Files' },
   q = { ':q!<cr>', 'Quit' },
   w = { ':w!<cr>', 'Save File' },
}, { prefix = '<leader>' })
