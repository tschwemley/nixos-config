{ nixosModules, home-manager, sops, ... }: 
let 
	mkSystem = configPath: {
		system = "x86_64-linux";
		modules = [
			# inputs.home-manager.nixosModule
			nixosModules.homeManager
			sops.nixosModules.sops
			configPath
		];
	};
in
{
	flake.nixosConfigurations = {
	# charizard = mkSystem ./charizard;
		moltres = mkSystem ./moltres;
	};
}
