local builtin = require("telescope.builtin")

local function show_methods()
	builtin.lsp_document_symbols({ symbols = { "function", "method", "constructor" } })
end

local function show_variables()
	builtin.lsp_document_symbols({ symbols = { "constant", "property", "variable" } })
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspGroup", {}),
	callback = function(e)
		local opts = function(desc)
			local opts = { buffer = e.buf }
			if desc ~= nil and desc ~= "" then
				opts["desc"] = desc
			end
			return opts
		end

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to Declaration"))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts())
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts())

		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts())
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts())
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts())

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts())
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts())

		vim.keymap.set("n", "<leader>lm", show_methods, opts())
		vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, opts())
		vim.keymap.set("n", "<leader>lv", show_variables, opts())
	end,
})
