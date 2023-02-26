local wk = require "which-key"

wk.register {
    ["<leader>l"] = {
        name = "LSP",

        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format Code" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        s = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },
    },
}
