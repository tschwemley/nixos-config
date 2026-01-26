vim.api.nvim_feedkeys("gO", "n", false)

-- When viewing a man file automatically open up a TOC buffer
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "man",
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			vim.api.nvim_feedkeys("gO", "n", false)
-- 		end, 0)
-- 	end,
-- })
--
