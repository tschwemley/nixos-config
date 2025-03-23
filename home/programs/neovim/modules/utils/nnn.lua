require("nnn").setup({
   replace_netrw = true,
})

vim.keymap.set("n", "<leader>e", "<cmd>NnnPicker %:p:h<cr>", { noremap = true })
vim.g.startuptime_exe_path = "nvim"
