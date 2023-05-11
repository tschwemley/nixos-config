{ inputs, ... }:
let
	mkHome = configPath: inputs.home-manager.lib.homeManagerConfiguration {
		# pkgs = inputs.nixpkgs.legacyPackages;
		pkgs = inputs.nixpkgs;
		lib = inputs.nixpkgs.lib;
		modules = [
			./common.nix
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
