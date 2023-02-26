local get_cwd = function()
	local cwd = require "telescope.utils".buffer_dir()
	local home_dir = os.getenv("HOME")
	if string.find(cwd, home_dir .. "/.config/nvim") then
		return home_dir .. "/.config/nvim"
	end
	return cwd
end

-- see :help telescope.setup() for default options
require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
	cwd = get_cwd()
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
  },
}

-- TODO: decide if keeping f variants, deleting, or splitting
require("which-key").register {
  ["<leader>s"] = {
    name = "Search",

    b = { ":Telescope buffers<CR>", "Search Buffers" },
    f = { ":Telescope find_files<CR>", "Search Files" },
    h = { ":Telescope help_tags<CR>", "Search Help" },
    k = { ":Telescope keymaps<CR>", "Search Keymaps" },
    m = { ":Telescope man_pages<CR>", "Search Man Pages" },
    o = { ":Telescope oldfiles<CR>", "Search Recent Files" },
    t = { ":Telescope live_grep<CR>", "Search rg text" },
    w = { ":Telescope grep_string<CR>", "Search rg under cursor" },
  },
}

-- TODO: which-key definition
local km = require "schwem.util.keymap"
km.nnoremap("<leader><enter>", ":Telescope current_buffer_fuzzy_find<CR>")
km.nnoremap("<leader>f", ":Telescope find_files<CR>")
