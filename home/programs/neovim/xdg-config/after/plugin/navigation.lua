local wk = require('which-key')

require("bufferline").setup()
require("lualine").setup()
require("nnn").setup()

wk.register({
  c = {":close<cr>", "Close File" },
  e = {"<cmd>NnnExplorer<cr>", "Explore Files"},
  q = {":q!<cr>", "Quit" },
  w = {":w!<cr>", "Save File" },
}, { prefix = "<leader>" })
