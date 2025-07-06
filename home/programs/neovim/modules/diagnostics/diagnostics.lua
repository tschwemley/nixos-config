require("trouble").setup()

require("todo-comments").setup({
   colors = {
      default = { "Identifier", "#7daea3" },
      error = { "DiagnosticError", "ErrorMsg", "#ea6962" },
      hint = { "DiagnosticHint", "#89b482" },
      info = { "DiagnosticInfo", "#7daea3" },
      ok = { "DiagnosticOk", "#a9b665" },
      test = { "Identifier", "#FF00FF" },
      warning = { "DiagnosticWarn", "WarningMsg", "#d8a657" },
   },

   keywords = {
      REF = {
         icon = "󰈙",
         color = "info",
         alt = { "DOCS", "DOC", "DOCUMENTATION", "REFERENCE", "LINK", "LINKS" },
      },

      TODO = { icon = " ", color = "info" },

      UPSTREAM = {
         icon = "󰞍",
         color = "info",
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
