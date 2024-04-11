{pkgs, ...}: {
	plugins = [
		(import ./gruvbox-material.nix pkgs)
	];
}
