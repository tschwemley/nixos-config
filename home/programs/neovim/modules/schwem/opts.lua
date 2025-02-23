vim.o.autoread = true          -- reload files on change
vim.o.colorcolumn = "100"      -- setting the color column
vim.o.errorbells = false       -- disabling error bells
vim.o.fileformat = "unix"      -- setting the file format
vim.o.grepformat = "%f:%l:%m"  -- setting the grep format
vim.o.grepprg = "rg --vimgrep" -- setting the grep program
vim.o.number = true            -- enabling line numbers
vim.o.relativenumber = true    -- enabling relative line numbers
vim.o.scrolloff = 8            -- setting the number of lines to keep above and below the cursor
vim.o.splitbelow = true        -- splitting below the current window
vim.o.splitright = true        -- splitting to the right of the current window
vim.o.wrap = false             -- disabling line wrapping

vim.opt.shm:append("W")        -- append 'W' to shortmessage flag to supress write messages

-- default tab settings
vim.o.cindent = true  -- C-style indentation
vim.o.shiftwidth = 4  -- the number of spaces for each indentation level
vim.o.softtabstop = 4 -- the number of spaces in a tab
vim.o.tabstop = 4     -- the number of spaces that a tab character counts for

-- nvim generated files
vim.o.backup = false                                           -- disabling backups
vim.o.swapfile = false                                         -- disabling swap files
vim.o.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo" -- setting the undo directory

-- search opts
vim.o.hlsearch = true   -- highlighting search matches
vim.o.ignorecase = true -- ignoring case in search
vim.o.incsearch = true  -- incremental search
vim.o.smartcase = true  -- smart case searching

-- gutter and status line opts
vim.o.cmdheight = 1        -- setting the height of the command line
vim.o.laststatus = 3       -- when last window will have status line | 3=always && only last window
vim.o.signcolumn = "yes"   -- always showing the sign column
vim.o.termguicolors = true -- enabling true color support in the terminal

-- having longer update degrades user experience
vim.o.timeout = true   -- enabling or disabling timeout for key mappings
vim.o.timeoutlen = 300 -- setting the timeout length in milliseconds
vim.o.updatetime = 50  -- setting the time before the cursor shape and other features are updated
