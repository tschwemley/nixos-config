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
})

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
   e = { '<cmd>NnnPicker %:p:h<cr>', 'Explore Files' },
   q = { ':q!<cr>', 'Quit' },
   w = { ':w!<cr>', 'Save File' },
}, { prefix = '<leader>' })
