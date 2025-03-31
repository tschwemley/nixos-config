vim.o.autoread = true
vim.o.colorcolumn = "100"
vim.o.errorbells = false
vim.o.fileformat = "unix"
vim.o.grepformat = "%f:%l:%m"
vim.o.grepprg = "rg --vimgrep"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.updatetime = 50
vim.o.wrap = false

vim.opt.shm:append("W") -- append 'W' to shortmessage flag to supress write messages

-- color settings
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

-- default tab settings
vim.o.cindent = true  -- C-style indentation
vim.o.shiftwidth = 4  -- the number of spaces for each indentation level
vim.o.softtabstop = 4 -- the number of spaces in a tab
vim.o.tabstop = 4     -- the number of spaces that a tab character counts for

-- nvim generated files
vim.o.backup = false
vim.o.swapfile = false
vim.o.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"

-- gutter and status line opts
vim.o.cmdheight = 1        -- setting the height of the command line
vim.o.laststatus = 3       -- when last window will have status line | 3=always && only last window
vim.o.signcolumn = "yes"   -- always showing the sign column
vim.o.termguicolors = true -- enabling true color support in the terminal

-- search opts
vim.o.hlsearch = true   -- highlighting search matches
vim.o.ignorecase = true -- ignoring case in search
vim.o.incsearch = true  -- incremental search
vim.o.smartcase = true  -- smart case searching
