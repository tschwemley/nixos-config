{ self, inputs, pkgs, config, ... }:
{
	flake = {
		nixosConfigurations = { 
			office = self.lib.mkLinuxSystem {
				imports = with pkgs; [ 
					self.nixosModules.home-manager
					self.users.schwem
					self.audio.all
					./../modules/fonts
					./office
					# ./../modules/desktop/steam.nix
					# self.nixosModules.dev.all
				];
			};
		};
	};
}
