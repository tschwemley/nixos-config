local yazi = require("yazi")

-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		yazi.setup({
			open_for_directories = true,
		})
	end,
})

vim.keymap.set("n", "<leader>e", function()
	yazi.yazi()
end)
