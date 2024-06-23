require('todo-comments').setup()
require('trouble').setup()

local trouble = require("trouble.sources.telescope")
local telescope = require("telescope")
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open },
      n = { ["<c-t>"] = trouble.open },
    },
  },
}

vim.keymap.set('n', '<leader>td', '<cmd>TodoTrouble<cr>', { noremap = true })
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble qflist toggle<cr>', { noremap = true })
vim.keymap.set('n', '<leader>tq', '<cmd>Trouble qflist toggle<cr>', { noremap = true })
