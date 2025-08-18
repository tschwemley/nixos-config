local M = {}

M.load_env = function(file)
	if file == nil then
		file = "~/.config/nvim/.env"
	end

	for line in io.lines(file) do
		local key, value = line:match("([^=]+)=(.*)")
		if key and value then
			vim.env[key] = value
		end
	end
end

return M
