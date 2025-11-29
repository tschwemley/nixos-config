local group = vim.api.nvim_create_augroup("vimrc-incsearch-highlight", {
	clear = true,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = group,
	pattern = { "/", "?" },
	command = "set hlsearch",
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = group,
	pattern = { "/", "?" },
	command = "set nohlsearch",
})
