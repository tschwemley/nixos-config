{ self, inputs, config, lib, pkgs, utils, ... }:
let 
mkHomeConfiguration = user: extraMods: inputs.home-manager.lib.homeManagerConfiguration {
	#pkgs = inputs.nixpkgs;

	modules = [
	{
		home-manger.users.${user} = user;
		home-manager.homeDirectory = "home/${user}";
	}
	./modules/common.nix
	] ++ extraMods;
};
in
{
	flake = {
		homeConfigurations = {
			k3s = mkHomeConfiguration "k3s" [];

			personal = mkHomeConfiguration "schwem" [
				./modules/desktop
			];

			work = {};
		};

		nixosModules = {
			home-manager = inputs.home-manager.nixosModule {
				inherit config lib pkgs utils;

				home-manager.stateVersion = "22.11";
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
			};
		};
	};
}
