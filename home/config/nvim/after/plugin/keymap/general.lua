local km = require("schwem.util.keymap")

-- TODO: decide if this should be kept or split further

km.nnoremap("<leader>c",  ":bd<CR>")

-- todo: better organize
km.nnoremap("<leader>w", ":w!<CR>")

-- Toggle current line or with count
km.nnoremap("<leader>/", function()
    return vim.v.count == 0
        and "<Plug>(comment_toggle_linewise_current)"
        or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true })
km.vnoremap("<leader>/", "<Plug>(comment_toggle_linewise_visual)")

km.nnoremap("<leader>C", "<cmd>e ~/.config/nvim/<cr>")

km.nnoremap("<C-h>", "<C-w>h")
km.nnoremap("<C-l>", "<C-w>l")
km.nnoremap("<C-j>", "<C-w>j")
km.nnoremap("<C-k>", "<C-w>k")
