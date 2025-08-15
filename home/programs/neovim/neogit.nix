{pkgs, ...}: {
	programs.neovim.plugins = [{
		type = "lua";	
		plugin = pkgs.vimPlugins.neogit;
		config = 
			# lua
			''
				local loaded = false
				local neogit = require("neogit")
				neogit.setup()

				-- local function load_git_plugins()
				-- 	if not loaded and vim.fs.root(0, ".git") ~= nil then
				-- 		require("gitsigns").setup()
				-- 		neogit.setup()
				--
				-- 		loaded = true
				-- 	end
				-- end

				local function handle_keymap()
					-- if not loaded then
					-- 	load_git_plugins()
					-- end

					neogit.open()
				end

				-- vim.api.nvim_create_autocmd("BufReadPre", { callback = load_git_plugins })

				vim.keymap.set("n", "<leader>g", handle_keymap)	
			'';
	}];
}
