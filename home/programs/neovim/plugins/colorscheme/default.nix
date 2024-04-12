{pkgs, ...}: {
	programs.neovim.plugins = [
		(import ./gruvbox-material.nix pkgs)
	];
}
