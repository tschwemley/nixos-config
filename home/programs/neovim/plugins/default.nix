{pkgs, ...}: let
	extraPackages = [];
	plugins = (import ./colorscheme pkgs)
		++ (import ./lsp pkgs)
		++ (import ./treesitter pkgs); 
in {
	programs.neovim = {
		inherit plugins;
	};
}
