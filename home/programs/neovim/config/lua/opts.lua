vim.opt.autoread = true
vim.opt.colorcolumn = "100"
vim.opt.errorbells = false
vim.opt.fileformat = "unix"
vim.opt.grepformat = "%f:%l:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 50
vim.opt.wrap = false

vim.opt.shm:append("W") -- append 'W' to shortmessage flag to supress write messages

vim.opt.termguicolors = true -- enabling true color support in the terminal

-- default tab settings
vim.opt.cindent = true  -- C-style indentation
vim.opt.shiftwidth = 4  -- the number of spaces for each indentation level
vim.opt.softtabstop = 4 -- the number of spaces in a tab
vim.opt.tabstop = 4     -- the number of spaces that a tab character counts for

-- nvim generated files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"

-- gutter and status line opts
vim.opt.cmdheight = 1        -- setting the height of the command line
vim.opt.laststatus = 3       -- when last window will have status line | 3=always && only last window
vim.opt.signcolumn = "yes"   -- always showing the sign column

-- search opts
vim.opt.hlsearch = true   -- highlighting search matches
vim.opt.ignorecase = true -- ignoring case in search
vim.opt.incsearch = true  -- incremental search
vim.opt.smartcase = true  -- smart case searching
