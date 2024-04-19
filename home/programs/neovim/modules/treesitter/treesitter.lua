require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,

		-- disable highlighting for large files
		disable = function(lang, buf)
			local max_filesize = 1000 * 1024 -- 1 MB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}
