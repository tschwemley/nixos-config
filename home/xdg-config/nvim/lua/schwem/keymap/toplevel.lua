local wk = require('which-key')

wk.register({
  c = {":close<cr>", "Close File" },
  e = {"<cmd>NnnExplorer<cr>", "Explore Files"},
  f = {"<cmd>Telescope find_files<cr>", "Find Files" },
  q = {":q!<cr>", "Quit" },
  w = {":w!<cr>", "Save File" },
}, { prefix = "<leader>" })
