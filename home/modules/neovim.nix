{ pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		extraLuaPackages = [];
		plugins = with pkgs.vimPlugins; [
			gruvbox-material
			packer-nvim # todo: packer might not be needed if I'm managing fully via nix
			telescope-nvim
			trouble-nvim
			nvim-dap
			#nvim-tresitter
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
