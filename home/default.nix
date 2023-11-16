{ self, inputs, config, lib, pkgs, utils, ... }:

{
	flake = {
		homeConfigurations = {
			k3s = {
				imports = [
					./modules/common.nix
					./modules/git.nix
				];
			};

 			personal = {
				imports = [
					./modules/common.nix
					./modules/git.nix
				];
			};

			work = {};
		};
	};
}
