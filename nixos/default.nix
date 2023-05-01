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
					./modules/common.nix
					./modules/networking
					./modules/pc/barrier.nix
					./modules/pc/browsers.nix
					./modules/pc/gaming.nix
					./modules/pc/rustdesk.nix
					./modules/audio/bluetooth.nix
					./modules/hardware/nvidia.nix
					./modules/xsession.nix
				];
			};
		};
	};
}
