-- TODO: I might want to make this [t]oggle instead of [t]erminal
local wk = require "which-key"

wk.register {
  ["<leader>t"] = {
    name = "Terminal",

    f = { "<cmd>ToggleTerm direction=float<CR>", "Floating Terminal" },
    h = { "<cmd>ToggleTerm direction=float<CR>", "Horizontal Terminal" },
    v = { "<cmd>ToggleTerm direction=float<CR>", "Veritcal Terminal" },
  },
}

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-km.", "<Cmd>wincmd h<CR>", opts)
  vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", opts)
  vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", opts)
  vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", opts)
end

-- if you only want tkm.se mappings for toggle term use term://*toggleterm#* instead
vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
