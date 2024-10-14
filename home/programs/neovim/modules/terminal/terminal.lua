vim.g.kitty_navigator_no_mappings = 1

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<c-h>", ":KittyNavigateLeft<cr>", opts)
vim.keymap.set("n", "<c-j>", ":KittyNavigateDown<cr>", opts)
vim.keymap.set("n", "<c-k>", ":KittyNavigateUp<cr>", opts)
vim.keymap.set("n", "<c-l>", ":KittyNavigateRight<cr>", opts)
