-- TODO: have this read from the json config
require("helpers").set_tabs(2)

local function prettifyJSON()
	vim.cmd("%!jq .")
end

local function minifyJSON()
	vim.cmd("%!jq -r tostring")
end

local function toggleFormat()
	if vim.api.nvim_buf_line_count(0) == 1 then
		prettifyJSON()
	else
		minifyJSON()
	end
end

vim.keymap.set("n", "<leader>lf", toggleFormat, { buffer = true, noremap = true })
vim.keymap.set("n", "<leader>lm", minifyJSON, { buffer = true, noremap = true })
vim.keymap.set("n", "<leader>lp", prettifyJSON, { buffer = true, noremap = true })
