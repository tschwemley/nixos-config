{ self, inputs, config, lib, pkgs, utils, ... }:

{
	flake = {
		nixosConfigurations = {
			office = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./office
					inputs.home-manager.nixosModule {
						home-manager.useGlobalPkgs = true;						
						home-manager.useUserPackages = true;						
						home-manager.users.schwem = self.homeConfigurations.personal;
					}
					./modules/fonts.nix
					./modules/nvidia.nix
					./modules/xsession.nix
					./modules/pc
					./modules/networking
				];
			};
		};
	};
}
