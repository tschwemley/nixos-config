require("conform").setup({
	formatters_by_ft = {
		go = { "gofmt", "goimports", "golines" },
		json = { "jq" },
		kdl = { "kdlfmt" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		php = { "phpcbf" },
		-- taplo = { "taplo" }, TODO: pretty sure this was a typo... delete after validating
		toml = { "taplo" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- vim.keymap.set("", "<leader>lf", function()
-- 	require("conform").format()
-- end)

-- Leave visual mode after range format
vim.keymap.set("", "<leader>lf", function()
	require("conform").format({ async = false }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "Format code" })
