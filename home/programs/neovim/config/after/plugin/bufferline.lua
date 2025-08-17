require("bufferline").setup()

vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { noremap = true })

vim.keymap.set("n", "<leader>bch", "<cmd>BufferLineCloseLeft<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseOthers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bcp", "<cmd>BufferLineClosePick<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseRight<cr>", { noremap = true })

vim.keymap.set("n", "<leader>bmh", "<cmd>BufferLineMovePrev<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bml", "<cmd>BufferLineMoveNext<cr>", { noremap = true })

vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", { noremap = true })
vim.keymap.set("n", "<leader>bsf", "<cmd>BufferLineSortByExtension<cr>", { noremap = true })
