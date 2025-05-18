local surround = require("mini.surround")

surround.setup()

vim.keymap.set("v", "S", surround.add, { noremap = true })
