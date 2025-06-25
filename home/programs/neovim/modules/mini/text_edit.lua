require("mini.align").setup()
require("mini.move").setup()
require("mini.pairs").setup()

-- TODO: Get this dialed in or revert back to using the tpope plugin
--
-- similar to tpope/surround
require("mini.surround").setup({
   mappings = {
      add = "ys",
      delete = "ds",
      find = "",
      find_left = "",
      highlight = "",
      replace = "cs",
      update_n_lines = "",

      -- Add this only if you don't want to use extended mappings
      suffix_last = "",
      suffix_next = "",
   },
   search_method = "cover_or_next",
})

-- Remap adding surrounding to Visual mode selection
vim.keymap.del("x", "ys")
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- Make special mapping for "add surrounding for line"
vim.keymap.set("n", "yss", "ys_", { remap = true })

-- NOTE: original custom surround config below [2025-06-12]
--
-- local surround = require("mini.surround")
--
-- surround.setup()
--
-- vim.keymap.set("v", "S", surround.add, { noremap = true })
