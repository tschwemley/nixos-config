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
			# office = mkSystem "office" [];
			office = inputs.nixpkgs.lib.nixosSystem {
				# inherit ();
				
				system = "x86_64-linux";
				modules = [
					# { system.stateVersion = "23.05"; }
					# ./modules/office.nix
					# self.homeConfigurations.personal
				];
			};
			
			kubernetesServer = {};
		};
	};
}
