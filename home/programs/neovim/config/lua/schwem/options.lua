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
-- TODO: I think this is getting mixed up occasionally but I'm too lazy to fix right now so always
-- unix LE until I can be assed to look into this some more vim.o.fileformats=unix,dos
vim.g.fileformats = "unix,dos"
vim.g.fileformat = "unix"

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

vim.o.cmdheight = 1
vim.o.colorcolumn = "120"
vim.o.signcolumn = "yes"
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.updatetime = 50

-- folds
vim.o.foldcolumn = "0" -- '0' -> no fold numbers in signcolumn
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- TODO: move this somewhere else if it works
-- Define the case-sensitive replace function
local function case_sensitive_replace(pattern, replacement)
   -- local function replace_func(match)
   --    local first_char = match:sub(1, 1)
   --    local is_uppercase = first_char:upper() == first_char
   --    local replaced_char = is_uppercase and replacement:sub(1, 1):upper() or replacement:sub(1, 1):lower()
   --    return replaced_char .. replacement:sub(2) .. match:sub(3)
   -- end

   print(pattern)
   print(replacement)

   -- local lines = vim.fn.getline(vim.fn.line("v"), vim.fn.line("."))
   -- local selection = table.concat(lines, "\n")
   -- local replaced = string.gsub(selection, "\\c\\<" .. pattern .. "\\>", replace_func)
   -- vim.fn.setline(".", replaced)
end

-- Create the user command
vim.api.nvim_create_user_command("CaseSensitiveReplace", case_sensitive_replace, { nargs = "2" })
