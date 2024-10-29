require("todo-comments").setup()
require("trouble").setup()

local trouble = require("trouble.sources.telescope")

vim.keymap.set("n", "<leader>ta", "<cmd>Trouble<cr>", { noremap = true })
vim.keymap.set("n", "<leader>td", "<cmd>TodoTrouble<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble diagnostics toggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { noremap = true })

-- command to automatically watch log
vim.api.nvim_create_user_command("WatchTail", 'set autoread | au CursorHold * checktime | call feedkeys("G")', {})
-- vim.api.nvim_create_user_command('WatchTail', function()
--     vim.o.autoread = true
--     vim.api.nvim_create_autocmd("CursorHold", {
--         pattern = "*",
--         command = "checktime"
--     })
--     vim.api.nvim_feedkeys("G", 'n', false)
-- end, {})
