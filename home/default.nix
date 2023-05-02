{ self, inputs, config, lib, pkgs, utils, ... }:

{
	flake = {
		homeConfigurations = {
			k3s = {
				imports = [
					./modules
					./modules/git.nix
				];
			};

 			personal = {
				imports = [
					./modules
					./modules/git.nix
				];
			};

			work = {};
		};
	};
}
