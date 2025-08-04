{pkgs, ...}: {
	programs.neovim.plugins = [{
		plugin = pkgs.vimPlugins.bufferline-nvim;
		# type = "lua";
		# config = 
		# 	# lua
		# 	''
		# 		require('bufferline').setup()	
		#
		# 		vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
		# 		vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { noremap = true })
		# 		vim.keymap.set("n", "<leader>bmh", "<cmd>BufferLineMovePrev<cr>", { noremap = true })
		# 		vim.keymap.set("n", "<leader>bml", "<cmd>BufferLineMoveNext<cr>", { noremap = true })
		# 		vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", { noremap = true })
		# 		vim.keymap.set("n", "<leader>bsf", "<cmd>BufferLineSortByExtension<cr>", { noremap = true })
		# 	'';
	}];

		xdg.configFile."nvim/after/plugin/bufferline.lua".text = 
			# lua
			''
				require('bufferline').setup()	

				vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
				vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { noremap = true })
				vim.keymap.set("n", "<leader>bmh", "<cmd>BufferLineMovePrev<cr>", { noremap = true })
				vim.keymap.set("n", "<leader>bml", "<cmd>BufferLineMoveNext<cr>", { noremap = true })
				vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", { noremap = true })
				vim.keymap.set("n", "<leader>bsf", "<cmd>BufferLineSortByExtension<cr>", { noremap = true })
			'';
}
