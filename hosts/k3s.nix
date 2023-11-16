# { self, inputs, config, lib, pkgs, utils, ... }:
{ inputs, ... }:

{
	inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			../nixos/modules/k3s
		];
	};
}
