vim.keymap.set("n", "<tab>", "<Plug>fugitive:=", { buffer = 0 })
vim.keymap.set("n", "q", "<Plug>fugitive:gq", { buffer = 0 })
vim.keymap.set("n", "P", ":!git push origin $(git branch --show-current)<cr>", { buffer = 0 })
