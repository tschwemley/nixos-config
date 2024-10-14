local dbee = require("dbee")

vim.g.db_ui_use_nerd_fonts = 1

dbee.setup()

-- vim.keymap.set("n", "<leader>ud", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "<leader>ud", dbee.toggle)
