local builtin = require("telescope.builtin")

local function show_methods()
   builtin.lsp_document_symbols({ symbols = { "function", "method" } })
end

local function show_variables()
   builtin.lsp_document_symbols({ symbols = { "constant", "property", "variable" } })
end

vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("LspGroup", {}),
   callback = function(e)
      local opts = { buffer = e.buf }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

      vim.keymap.set("n", "[d", function()
         vim.diagnostic.goto_next()
      end, opts)
      vim.keymap.set("n", "]d", function()
         vim.diagnostic.goto_prev()
      end, opts)

      vim.keymap.set("n", "<leader>ll", builtin.lsp_document_symbols, opts)
      vim.keymap.set("n", "<leader>lm", show_methods, opts)
      vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, opts)
      vim.keymap.set("n", "<leader>lv", show_variables, opts)
   end,
})
