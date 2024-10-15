vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%m"

-- show relative numbers && curline
vim.o.number = true
vim.o.relativenumber = true

-- eww
vim.o.errorbells = false

-- format tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.cindent = true

-- always use unix line endings by default
vim.g.fileformat = "unix"

vim.o.wrap = false

-- nvim generated files
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. ".local/state/nvim/undo"

-- search options
vim.o.hlsearch = true
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

vim.o.colorcolumn = "120"

-- controls messages sent
vim.opt.shortmess:append("W")
