{ self, inputs, pkgs, config, ... }:
{
	flake = {
		nixosConfigurations = { 
			office = self.lib.mkLinuxSystem {
				imports = with pkgs; [ 
					self.nixosModules.home-manager
					self.users.pcs
					self.audio.all
					./../modules/fonts
					./../modules/desktop/steam.nix
					./office
				];
			};

			luxembourg = self.lib.mkLinuxSystem {
				imports = with pkgs; [ 
					self.nixosModules.home-manager
					self.users.cloud.lux
					./luxembourg
				];
			};
		};
	};
}
