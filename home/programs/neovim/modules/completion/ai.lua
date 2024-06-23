local codecompanion = require('codecompanion')
local anthropic = require("codecompanion.adapters").use("anthropic", {
	env = {
		api_key = "cmd:sops -d --extract '[\"anthropic-api-key\"]' ~/nixos-config/home/secrets.yaml 2>/dev/null",
	},
})

local ollama = require("codecompanion.adapters").use("ollama", {
   schema = {
      model = {
         default = "deepseek-coder-v2",
         -- default = "dolphin-llama3",
      },
   },
})

codecompanion.setup({
	adapters = {
		anthropic = anthropic,
		ollama = ollama,
	},
	strategies = {
		chat = "ollama",
		inline = "ollama",
		tool = "ollama",
	},
})

vim.keymap.set('n', '<leader>ca', codecompanion.actions, { noremap = true })
vim.keymap.set('n', '<leader>cc', codecompanion.chat, { noremap = true })
vim.keymap.set('n', '<leader>ct', codecompanion.toggle, { noremap = true })
