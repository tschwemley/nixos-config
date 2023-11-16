{ self, inputs, ... }:
let
	mkSystem = name: extraMods: inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [ 
			../modules/shell
			# self.nixosModules.home-manager
			# self.nixosModules.development
			# self.nixosModules.shell
			# self.nixosModules.terminal
		] ++ extraMods;
	};
in
{
	flake = {
		nixosConfigurations = {
			office = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./office
					self.nixosModules.home-manager
					self.homeConfigurations.personal
				];
			};
			
			kubernetesServer = {};
		};
	};
}
