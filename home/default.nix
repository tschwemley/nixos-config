{ self, inputs, config, lib, pkgs, utils, ... }:

{
	flake = {
		homeConfigurations = {
			#k3s = mkHomeConfiguration "k3s" [];

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
