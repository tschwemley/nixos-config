local neogit = require("neogit")

require("gitsigns").setup()
neogit.setup()

vim.keymap.set("n", "<leader>g", neogit.open)
