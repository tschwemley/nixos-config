vim.g.mapleader = " ";
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('c', 'jk', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('v', 'jk', '<Esc>', {noremap = true})

-- show relative numbers && curline
vim.o.number = true
vim.o.relativenumber = true

-- eww
vim.o.errorbells = false

-- format tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

vim.o.wrap = false

-- nvim generated files
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. ".local/state/nvim/undo"

-- search options
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- used for bufferline
vim.o.termguicolors = true

-- min number of lines to always keep above and below cursor
vim.o.scrolloff = 8

vim.o.signcolumn = "yes"
vim.o.cmdheight = 1

-- having longer update degrades user experience
vim.o.updatetime = 50

vim.o.timeout = true
vim.o.timeoutlen = 300

-- TODO: consider switching to one of the plugins or writing my own func to only show when char
-- reaches column limit
vim.o.colorcolumn = "100"

