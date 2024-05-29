-- require("codecompanion").setup()
local anthropic = require("codecompanion.adapters").use("anthropic", {
	env = {
		api_key = "cmd:sops -d --extract '[\"anthropic-api-key\"]' ~/nixos-config/home/secrets.yaml 2>/dev/null",
	},
})

local ollama = require("codecompanion.adapters").use("ollama", {
   schema = {
      model = {
         default = "dolphin-llama3",
      },
   },
})

require("codecompanion").setup({
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
