local builtin = require("telescope.builtin")

vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
vim.keymap.set("n", "<leader>b<space>", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bmh", "<cmd>BufferLineMovePrev<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bml", "<cmd>BufferLineMoveNext<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bsf", "<cmd>BufferLineSortByExtension<cr>", { noremap = true })

vim.keymap.set("n", "<leader>bd", ":bd<cr>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<cr>", { noremap = true })
vim.keymap.set("n", "<leader>w", ":w<cr>", { noremap = true })

vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true })
