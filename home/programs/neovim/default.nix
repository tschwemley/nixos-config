{ lib, ... }:
{
	imports = [
		./colors
		./core
		./diagnostics
		./files
		./formatting
		./ftplugin
		./linting
		./lsp
		./mini
		./telescope
		./treesitter

		# TODO: figure out home for these -- OR -- use the architecture: plugin/ ftplugin/ ... for nix modules
		./bufferline.nix
		./neogit.nix
		

		# TODO: slowly move to a flat structure then delete this import
		# ./modules
	];

	programs.neovim = {
		enable = true;
		# extraLuaConfig = 
		# 	# lua
		# 	''
		# 		vim.o.colorscheme = "gruvbox";
		# 	'';
		# plugins = with pkgs.vimPlugins; [
		# 	everforest
		# 	gruvbox-nvim
		# ];

		defaultEditor = lib.mkDefault true;
		vimAlias = true;
		vimdiffAlias = true;
		withPython3 = true;
		withNodeJs = true;
	};
}
