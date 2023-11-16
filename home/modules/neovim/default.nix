{ pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		extraLuaPackages = [];
		plugins = with pkgs.vimPlugins; [
			gruvbox-material
			lualine-nvim
			nnn-vim
			nvim-cmp
			nvim-dap
			telescope-nvim
			toggleterm-nvim
			trouble-nvim
			nvim-treesitter
			vim-dadbod
			vim-dadbod-ui
			vim-dadbod-completion
			which-key-nvim
		];
		withNodeJs = true;
		withPython3 = true;
		vimAlias = true;
		vimdiffAlias = true;
	};
}
