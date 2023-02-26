{ self, inputs, config, ... }:
{
	flake = {
		nixosConfigurations = { 
			office = self.lib.mkLinuxSystem {
				imports = [ 
					self.nixosModules.home-manager
					self.users.schwem
					self.audio.all
					./office
				];
			};
		};
	};
}
