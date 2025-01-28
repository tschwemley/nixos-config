-- vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	pattern = { "*programs/**/*.nix" },
	callback = function(ev)
		print(string.format("event fired: %s", vim.inspect(ev)))
		local snippet = {
			"{pkgs, ...}: {",
			"  home.packages = with pkgs; [];",
			"}",
		}
		vim.fn.writefile(snippet, ev.file)
	end,
})
