-- Set up mapping to close the location list when hitting Enter
vim.keymap.set("n", "<CR>", "<cmd>lclose<CR><cr>", { buffer = true })
vim.keymap.set("n", "q", ":q<cr>", { buffer = true })
