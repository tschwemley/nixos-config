require("opts")
-- require("dotenv").load_env("~/.config/sops-nix/secrets/neovim.env")

-- Init colorscheme immediately to ensure load prior to any plugin that references for styling
vim.go.background = "dark"
vim.go.termguicolors = true -- enabling true color support in the terminal
vim.cmd("colorscheme gruvbox")

-- TODO: move out basic keymaps or keep here?
vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

vim.keymap.set("n", "<leader>bd", ":bd<cr>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w!<cr>", { noremap = true, silent = true })

vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true })

-- TODO: move this elsewhere
local surround_block = function(opts)
	local start_line = opts.range == 2 and vim.fn.getpos("'<")[2] or opts.line1
	local end_line = opts.range == 2 and vim.fn.getpos("'>")[2] or opts.line2

	local text1 = vim.fn.input("Text above: ")
	local text2 = vim.fn.input("Text below: ")

	vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, {
		text1,
	})
	vim.api.nvim_buf_set_lines(0, end_line, end_line, false, { text2 })
end

vim.api.nvim_create_user_command("SB", surround_block, { range = 2 })
vim.api.nvim_create_user_command("SurroundBlock", surround_block, { range = 2 })
---
