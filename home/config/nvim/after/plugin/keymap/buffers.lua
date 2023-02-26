local wk = require "which-key"

wk.register {
    ["<leader>b"] = {
        name = "Buffers",

        -- Management
        f = { "<cmd>Telescope buffers<CR>", "List Buffers" },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close Left Buffers" },
        l = { "<cmd>BufferLineCloseRight<cr>", "Close Right Buffers" },

        -- Navigation
        b = { "<cmd>bp<cr>", "Prev Buffer" },
        n = { "<cmd>bn<cr>", "Next Buffer" },
        j = { "<cmd>BufferLinePick<cr>", "Jump to Buffer" },
    },
}
