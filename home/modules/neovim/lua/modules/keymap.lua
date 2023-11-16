local register = require("which-key").register

-- Completion

-- LSP
wk.register({
   l = {
      name = "LSP", -- group name
      d = { "<cmd>Telescope lsp_definition<cr>", "Go To/Show Definition(s)" },
      i = { "<cmd>Telescope lsp_implementations<cr>", "Go To/Show Implementation(s)" },
      r = { "<cmd>Telescope lsp_references<cr>", "List References" },
   },
}, { prefix = "<leader>" })

-- Navigation

-- PKM

-- Search


-- 
-- see: :h which-key - or - https://github.com/folke/which-key.nvim
-- 
