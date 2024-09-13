local codecompanion = require("codecompanion")

codecompanion.setup({
	adapters = {
		anthropic = function()
			return require("codecompanion.adapters").extend("openai", {
				env = {
					api_key = "cmd:sops -d --extract '[\"anthropic-api-key\"]' ~/nixos-config/home/secrets/secrets.yaml 2>/dev/null",
				},
			})
		end,

		ollama = {
			schema = {
				model = {
					default = "codestral:22b-v0.1-q8_0",
				},
			},
		},
	},

	strategies = {
		chat = {
			adapter = "ollama",
		},
		inline = {
			adapter = "ollama",
		},
		tool = {
			adapter = "ollama",
		},
	},
})

vim.keymap.set("n", "<leader>ca", codecompanion.actions, { noremap = true })
vim.keymap.set("n", "<leader>cc", codecompanion.chat, { noremap = true })
vim.keymap.set("n", "<leader>ct", codecompanion.toggle, { noremap = true })
