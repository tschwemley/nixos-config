local aider = require("aider")

local function aider_open()
	aider.AiderOpen(
		"aider -c ~/.config/aider/aider.conf.yml --model-settings-file ~/.config/aider/.aider.model.settings.yml"
	)
end

-- REF: https://github.com/joshuavial/aider.nvim/?tab=readme-ov-file#setup
aider.setup()
vim.keymap.set("n", "<leader>Ao", aider_open)
vim.keymap.set("n", "<leader>Am", aider.AiderAddModifiedFiles)
