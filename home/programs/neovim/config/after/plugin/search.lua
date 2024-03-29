require('which-key').register({
   f = { '<cmd>Telescope find_files<cr>', 'Find Files', },
   s = {
      name = 'Search...',
      b = { '<cmd>Telescope buffers<cr>', 'Search Buffers', },
      h = { '<cmd>Telescope help_tags<cr>', 'Search Help Tags', },
      k = { '<cmd>Telescope keymaps<cr>', 'Search Keybindings', },
      m = { '<cmd>Telescope man_pages<cr>', 'Search Man Pages', },
      T = { '<cmd>TodoTelescope<cr>', 'Search TODOs', },
      t = { '<cmd>Telescope live_grep<cr>', 'Search Text', },
      w = { '<cmd>Telescope grep_string<cr>', 'Search Word Under Cursor' },
   },
}, { prefix = '<leader>' })
