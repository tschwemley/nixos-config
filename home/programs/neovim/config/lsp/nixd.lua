---@type vim.lsp.Config
return {
	settings = {
		nixd = {
			options = {
				nixos = {
					expr = "(builtins.getFlake (toString ./.)).nixosConfigurations." .. vim.fn.hostname() .. "options",
				},
			},
		},
	},
}
