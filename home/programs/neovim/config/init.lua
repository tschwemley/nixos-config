require('opts')

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
