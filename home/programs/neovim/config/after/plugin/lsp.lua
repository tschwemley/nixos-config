local builtin = require("telescope.builtin")

local function show_methods()
	builtin.lsp_document_symbols({ symbols = { "function", "method", "constructor" } })
end

local function show_variables()
	builtin.lsp_document_symbols({ symbols = { "constant", "property", "variable" } })
end

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)

vim.keymap.set("n", "<leader>lm", show_methods)
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols)
vim.keymap.set("n", "<leader>lv", show_variables)

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
end)

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
end)
