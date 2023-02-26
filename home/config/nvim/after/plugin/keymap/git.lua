local wk = require('which-key')

wk.register({
    ["<leader>g"] = {
        name = "Git",

        g = { ":lua lazygit_toggle()<CR>", "lazygit" },
    }
})


