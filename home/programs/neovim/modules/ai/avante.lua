---@diagnostic disable: missing-fields

-- see: https://github.com/yetone/avante.nvim/blob/78d6c389b4f94b2040c87c82558ea6cd9328ef95/lua/avante/config.lua#L331
require("avante").setup({
	auto_suggestions_provider = "openrouter",
	provider = "openrouter",

	vendors = {
		openrouter = {
			__inherited_from = "openai",
			api_key_name = "cmd:cat /home/schwem/.config/sops-nix/secrets/openrouter_api_key",
			endpoint = "https://openrouter.ai/api/v1",
			-- model = "deepseek/deepseek-chat-v3-0324:free",
			model = "deepseek/deepseek-chat-v3-0324",
		},
	},
})
