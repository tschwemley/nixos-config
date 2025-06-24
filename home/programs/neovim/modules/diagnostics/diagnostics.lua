require("trouble").setup()

require("todo-comments").setup({
   keywords = {
      REF = {
         icon = "󰈙",
         color = "info",
         alt = { "DOCS", "DOC", "DOCUMENTATION", "REFERENCE", "LINK", "LINKS" },
      },

      UPSTREAM = {
         icon = "󰞍",
         -- alt = { "DOCS", "DOC", "DOCUMENTATION", "REFERENCE", "LINK", "LINKS" },
         color = "hint", -- TODO: decide which color to use: error, hint, warning, info, default, or test (prob not test tho)
      },
   },
})

-- local trouble = require("trouble.sources.telescope")

vim.keymap.set("n", "<leader>ta", "<cmd>Trouble<cr>", { noremap = true })
vim.keymap.set("n", "<leader>td", "<cmd>TodoTrouble<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble diagnostics toggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { noremap = true })

-- command to automatically watch log
vim.api.nvim_create_user_command("WatchTail", 'set autoread | au CursorHold * checktime | call feedkeys("G")', {})
