vim.opt.number = true
vim.opt.relativenumber = true

-- eww
vim.opt.errorbells = false

-- format tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.wrap = false

-- nvim generated files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. ".local/state/nvim/undo"

-- search options
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- min number of lines to always keep above and below cursor
vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.cmdheight = 1

-- having longer update degrades user experience
vim.opt.updatetime = 50

-- don't pass message to |ins-completion-menu|
vim.opt.shortmess:append("c")

vim.opt.colorcolumn = "100"

vim.g.mapleader = " "
