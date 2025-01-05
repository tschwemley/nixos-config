vim.o.colorcolumn = "100" -- Built-in option for setting the color column
vim.o.errorbells = false -- Built-in option for disabling error bells
vim.o.fileformat = "unix" -- Built-in option for setting the file format
vim.o.grepformat = "%f:%l:%m" -- Built-in option for setting the grep format
vim.o.grepprg = "rg --vimgrep" -- Built-in option for setting the grep program
vim.o.number = true -- Built-in option for enabling line numbers
vim.o.relativenumber = true -- Built-in option for enabling relative line numbers
vim.o.scrolloff = 8 -- Built-in option for setting the number of lines to keep above and below the cursor
vim.o.splitbelow = true -- Built-in option for splitting below the current window
vim.o.splitright = true -- Built-in option for splitting to the right of the current window
vim.o.wrap = false -- Built-in option for disabling line wrapping

-- append 'W' to shortmessage flag to supress write messages
vim.opt.shm:append("W")

-- default tab settings
vim.o.cindent = true -- Built-in option for C-style indentation
vim.o.shiftwidth = 4 -- Built-in option for the number of spaces for each indentation level
vim.o.softtabstop = 4 -- Built-in option for the number of spaces in a tab
vim.o.tabstop = 4 -- Built-in option for the number of spaces that a tab character counts for

-- nvim generated files
vim.o.backup = false -- Built-in option for disabling backups
vim.o.swapfile = false -- Built-in option for disabling swap files
vim.o.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo" -- Built-in option for setting the undo directory

-- search opts
vim.o.hlsearch = true -- Built-in option for highlighting search matches
vim.o.ignorecase = true -- Built-in option for ignoring case in search
vim.o.incsearch = true -- Built-in option for incremental search
vim.o.smartcase = true -- Built-in option for smart case searching

-- gutter and status line opts
vim.o.cmdheight = 1 -- Built-in option for setting the height of the command line
vim.o.signcolumn = "yes" -- Built-in option for always showing the sign column
vim.o.termguicolors = true -- Built-in option for enabling true color support in the terminal

-- having longer update degrades user experience
vim.o.timeout = true -- Built-in option for enabling or disabling timeout for key mappings
vim.o.timeoutlen = 300 -- Built-in option for setting the timeout length in milliseconds
vim.o.updatetime = 50 -- Built-in option for setting the time before the cursor shape and other features are updated
