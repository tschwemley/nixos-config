{ self, inputs, config, lib, pkgs, utils, ... }:
let
	/*
	mkHomeModule = extraMods: inputs.home-manager.nixosModule {
	};
	*/
in
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
					./modules/pc/brave.nix
				];
			};
			
			kubernetesServer = {};
		};
	};
}
