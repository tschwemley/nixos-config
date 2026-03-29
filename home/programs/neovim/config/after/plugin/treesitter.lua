-- NOTE: this is coppied directly from https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--       customize/remove as needed
require("nvim-treesitter-textobjects").setup({
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * selection_mode: eg 'v'
		-- and should return true of false
		include_surrounding_whitespace = false,
	},
})

-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "am", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)

-- require("nvim-treesitter.configs").setup({
-- 	highlight = {
-- 		enable = true,
--
-- 		-- disable highlighting for large files
-- 		disable = function(_, buf)
-- 			local max_filesize = 1000 * 1024 -- 1 MB
-- 			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
-- 			if ok and stats and stats.size > max_filesize then
-- 				return true
-- 			end
-- 		end,
-- 	},
-- 	incremental_selection = {
-- 		enable = true,
-- 	},
-- 	indent = {
-- 		enable = true,
-- 	},
-- })
