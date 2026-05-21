require("conform").setup({
	formatters_by_ft = {
		go = { "gofmt", "goimports", "golines" },
		json = { "jq" },
		kdl = { "kdlfmt" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		php = { "phpcbf" },
		toml = { "taplo" },
	},

	format_on_save = function(buffer_num)
		if vim.g.disable_autoformat or vim.b[buffer_num].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

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

-- create commands for enabling/disabling autoformatting
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- :FormatDisable! disables autoformat for this buffer only
		vim.b.disable_autoformat = true
	else
		-- :FormatDisable disables autoformat globally
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true, -- allows the ! variant
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
