-- Start with telescope file picker open, unless viewing a man page
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if vim.bo.filetype == "man" then
-- 			return
-- 		end
--
-- 		if vim.fn.argv(0) == "" then
-- 			require("telescope.builtin").find_files()
-- 		end
-- 	end,
-- })

-- When opening a TOC buffer automatically move it to the left and make the width equal to the line
-- with the most characters + 4 (for padding).
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		if vim.w.quickfix_title and vim.w.quickfix_title:match("Table of contents") then
			vim.cmd("wincmd H")
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local max_len = 0
			for _, line in ipairs(lines) do
				max_len = math.max(max_len, #line)
			end
			vim.api.nvim_win_set_width(0, max_len + 4)
		end
	end,
})
