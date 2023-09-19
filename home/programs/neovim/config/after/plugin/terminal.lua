require('toggleterm').setup({})
--    direction = 'float',
--    open_mapping = [[<C-\>]],
--    insert_mappings = true,
--    terminal_mappings = true,
-- })

require('which-key').register({
   t = {
      name = 'Terminal',
      f = { '<cmd>ToggleTerm direction=float<cr>', 'Floating Terminal' },
      h = { '<cmd>ToggleTerm direction=horizontal<cr> size=10', 'Horizontal Terminal' },
      t = { '<cmd>ToggleTerm direction=float<cr>', 'Terminal Tab' },
      v = { '<cmd>ToggleTerm direction=vertical size=60<cr>', 'Vertical Terminal' },
   },
   { prefix = '<leader>' }
})
