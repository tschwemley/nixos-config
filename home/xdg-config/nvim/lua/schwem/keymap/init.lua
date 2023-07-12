local wk = require('which-key')
-- local debug = require("schwem.keymap.debug")
-- local lsp = require("schwem.keymap.debug")
-- local search = require("schwem.keymap.search")

wk.register({
  c = {":close<cr>", "Close File" },
  --d = debug,
  e = {"<cmd>NnnExplorer<cr>", "Explore Files"},
  f = {"<cmd>Telescope find_files<cr>", "Find Files" },
  --l = lsp,
  q = {":q!<cr>", "Quit" },
  --s = search,
  w = {":w!<cr>", "Save File" },
}, { prefix = "<leader>" })
