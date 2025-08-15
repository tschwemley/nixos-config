{pkgs, ...}: {
	programs.neovim.plugins = [ pkgs.vimPlugins.mini-nvim ];
	xdg.configFile = {
		"nvim/after/plugin/mini.files.lua".text = 
			# lua
			''
				require('mini.files').setup()						

				vim.keymap.set('n', '<leader>e', MiniFiles.open)
			'';
	};
}
