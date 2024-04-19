vim.o.grepprg = 'rg --vimgrep';
vim.o.grepformat = '%f:%l:%m';

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
-- TODO: I think this is getting mixed up occasionally but I'm too lazy to fix right now so always
-- unix LE until I can be assed to look into this some more vim.o.fileformats=unix,dos
vim.g.fileformats = unix, dos
vim.g.fileformat = unix

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

-- folds
vim.o.foldcolumn = '0' -- '0' -> no fold numbers in signcolumn
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
