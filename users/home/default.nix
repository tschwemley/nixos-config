{ inputs, ... }:
let
	pkgs = inputs.nixpkgs;
	lib = inputs.nixpkgs.lib;
	mkHome = configPath: inputs.home-manager.lib.homeManagerConfiguration {
		inherit pkgs lib;
		modules = [
			./config/home/bat.nix
			./config/home/git.nix
			./config/home/home-manager.nix
			./config/home/shell.nix
			./config/home/neovim
			configPath
		];
	};
in
{
	flake.homeConfigurations = {
		k3s = mkHome ./k3s.nix;
		personal = mkHome ./k3s.nix;
		work = mkHome ./work.nix;
	};
}
